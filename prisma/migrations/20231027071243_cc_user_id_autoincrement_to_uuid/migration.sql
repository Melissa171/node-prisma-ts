/*
  Warnings:

  - The primary key for the `CC` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_CC" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "NT" TEXT NOT NULL,
    "CN" BIGINT NOT NULL,
    "Validate" DATETIME NOT NULL,
    "CVV" INTEGER NOT NULL,
    "userId" TEXT NOT NULL,
    CONSTRAINT "CC_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_CC" ("CN", "CVV", "NT", "Validate", "id", "userId") SELECT "CN", "CVV", "NT", "Validate", "id", "userId" FROM "CC";
DROP TABLE "CC";
ALTER TABLE "new_CC" RENAME TO "CC";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
