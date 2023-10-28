-- CreateTable
CREATE TABLE "User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "date_of_birthday" DATETIME NOT NULL,
    "cpf" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "CC" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "CN" INTEGER NOT NULL,
    "Validate" INTEGER NOT NULL,
    "CVV" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "CC_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "User_name_key" ON "User"("name");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_cpf_key" ON "User"("cpf");
