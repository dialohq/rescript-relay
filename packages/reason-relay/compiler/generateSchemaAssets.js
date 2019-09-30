function generateSchemaAssets(schema, targetPath) {
  let enums = schema.data.__schema.types
    .filter(({ kind, name }) => kind === "ENUM" && !name.startsWith("_"))
    .map(e => {
      const { name, enumValues } = e;
      const values = enumValues.map(v => v.name);

      let enumT = `type t = [ ${values
        .map(v => ` | \`${v}`)
        .join("")} | \`FUTURE_ADDED_VALUE__ ]`;

      return `
      module Enum_${name}: {
        ${enumT};
        type wrapped;
        let unwrap: wrapped => t;
        let wrap: t => wrapped;
      } = {
        ${enumT};
        type wrapped;
        
        external __unwrap: wrapped => string = "%identity";
        external __wrap: string => wrapped = "%identity";
        
        let unwrap = wrapped => switch(wrapped |> __unwrap) {
          ${values.map(val => `| "${val}" => \`${val}`).join("")}
          | _ => \`FUTURE_ADDED_VALUE__
        };
        
        let wrap = t => switch(t) {
          ${values.map(val => `| \`${val} => "${val}"`).join("")}
          | \`FUTURE_ADDED_VALUE__ => ""
        } |> __wrap;
      };
      `;
    })
    .join("\n\n");

  fs.writeFileSync(
    path.resolve(targetPath + "/SchemaAssets.re"),
    printRE(
      parseRE(`
/** This file is autogenerated by ReasonRelay and should not be modified manually. */

/**
 * ENUMS
 * Helpers for wrapping/unwrapping enums.
 */

${enums}
     `)
    )
  );
}

module.exports = {
  generateSchemaAssets
};
