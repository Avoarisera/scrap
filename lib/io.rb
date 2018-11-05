require "google_drive"




session = GoogleDrive::Session­.from_config("config­.json")

session.upload_from_­file("jeprie.csv", "jeprie.csv", convert: false)