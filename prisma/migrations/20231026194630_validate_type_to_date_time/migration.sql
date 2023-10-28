/*
  Warnings:

  - You are about to alter the column `Validate` on the `CC` table. The data in that column could be lost. The data in that column will be cast from `Int` to `DateTime`.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_CC" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "NT" TEXT NOT NULL,
    "CN" INTEGER NOT NULL,
    "Validate" DATETIME NOT NULL,
    "CVV" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "CC_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_CC" ("CN", "CVV", "NT", "Validate", "id", "userId") SELECT "CN", "CVV", "NT", "Validate", "id", "userId" FROM "CC";
DROP TABLE "CC";
ALTER TABLE "new_CC" RENAME TO "CC";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
