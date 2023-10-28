/*
  Warnings:

  - Added the required column `NT` to the `CC` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_CC" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "NT" TEXT NOT NULL,
    "CN" INTEGER NOT NULL,
    "Validate" INTEGER NOT NULL,
    "CVV" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "CC_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_CC" ("CN", "CVV", "Validate", "id", "userId") SELECT "CN", "CVV", "Validate", "id", "userId" FROM "CC";
DROP TABLE "CC";
ALTER TABLE "new_CC" RENAME TO "CC";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
