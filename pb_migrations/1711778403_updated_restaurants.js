/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("v60ybubz9buiex9")

  // remove
  collection.schema.removeField("ahxs1g81")

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("v60ybubz9buiex9")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "ahxs1g81",
    "name": "open",
    "type": "bool",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {}
  }))

  return dao.saveCollection(collection)
})
