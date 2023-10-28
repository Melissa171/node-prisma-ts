/*
  Warnings:

  - The primary key for the `User` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_CC" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
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
CREATE TABLE "new_User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "date_of_birthday" DATETIME NOT NULL,
    "cpf" TEXT NOT NULL
);
INSERT INTO "new_User" ("cpf", "date_of_birthday", "email", "id", "name", "password") SELECT "cpf", "date_of_birthday", "email", "id", "name", "password" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User_name_key" ON "User"("name");
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");
CREATE UNIQUE INDEX "User_cpf_key" ON "User"("cpf");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
