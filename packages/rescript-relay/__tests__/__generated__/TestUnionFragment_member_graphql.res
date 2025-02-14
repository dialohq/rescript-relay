/* @generated */
%%raw("/* @generated */")
module Types = {
  @@ocaml.warning("-30")
  
  type enum_OnlineStatus = private [>
    | #Idle
    | #Offline
    | #Online
    ]
  
  type enum_OnlineStatus_input = [
    | #Idle
    | #Offline
    | #Online
    ]
  
  type fragment_User = {
    onlineStatus: option<enum_OnlineStatus>,
    firstName: string,
  }
  
  type fragment_Group = {
    name: string,
  }
  
  
  type fragment = [
    | #User(fragment_User)
  
    | #Group(fragment_Group)
    | #UnselectedUnionMember(string)
  ]
}

let unwrap_fragment: {. "__typename": string } => [
  | #User(Types.fragment_User)

  | #Group(Types.fragment_Group)
  | #UnselectedUnionMember(string)
] = u => switch u["__typename"] {
 | "User" => #User(u->Obj.magic) 
 | "Group" => #Group(u->Obj.magic) 
 | v => #UnselectedUnionMember(v)
}

let wrap_fragment: [
  | #User(Types.fragment_User)

  | #Group(Types.fragment_Group)
  | #UnselectedUnionMember(string)
] => {. "__typename": string } = v => switch v {
 | #User(v) => v->Obj.magic 
 | #Group(v) => v->Obj.magic 
 | #UnselectedUnionMember(v) => {"__typename": v} 
}

module Internal = {
  type fragmentRaw
  let fragmentConverter: 
    Js.Dict.t<Js.Dict.t<Js.Dict.t<string>>> = 
    %raw(
      json`{"__root":{"":{"u":"fragment"},"onlineStatus":{"n":""}}}`
    )
  
  let fragmentConverterMap = {
    "fragment": unwrap_fragment,
  }
  
  let convertFragment = v => v->RescriptRelay.convertObj(
    fragmentConverter, 
    fragmentConverterMap, 
    Js.undefined
  )
}
type t
type fragmentRef
external getFragmentRef:
  RescriptRelay.fragmentRefs<[> | #TestUnionFragment_member]> => fragmentRef = "%identity"


module Utils = {
  open Types
  external onlineStatus_toString:
  enum_OnlineStatus => string = "%identity"
  external onlineStatus_input_toString:
  enum_OnlineStatus_input => string = "%identity"
}
type relayOperationNode
type operationType = RescriptRelay.fragmentNode<relayOperationNode>


let node: operationType = %raw(json` {
  "argumentDefinitions": [],
  "kind": "Fragment",
  "metadata": null,
  "name": "TestUnionFragment_member",
  "selections": [
    {
      "alias": null,
      "args": null,
      "kind": "ScalarField",
      "name": "__typename",
      "storageKey": null
    },
    {
      "kind": "InlineFragment",
      "selections": [
        {
          "alias": null,
          "args": null,
          "kind": "ScalarField",
          "name": "firstName",
          "storageKey": null
        },
        {
          "alias": null,
          "args": null,
          "kind": "ScalarField",
          "name": "onlineStatus",
          "storageKey": null
        }
      ],
      "type": "User",
      "abstractKey": null
    },
    {
      "kind": "InlineFragment",
      "selections": [
        {
          "alias": null,
          "args": null,
          "kind": "ScalarField",
          "name": "name",
          "storageKey": null
        }
      ],
      "type": "Group",
      "abstractKey": null
    }
  ],
  "type": "Member",
  "abstractKey": "__isMember"
} `)


