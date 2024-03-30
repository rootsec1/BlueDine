/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("b8ui71jdrgpm7fz")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "fs32it0l",
    "name": "price",
    "type": "text",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "pattern": ""
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("b8ui71jdrgpm7fz")

  // remove
  collection.schema.removeField("fs32it0l")

  return dao.saveCollection(collection)
})
