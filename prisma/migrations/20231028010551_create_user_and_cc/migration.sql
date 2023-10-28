-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "username" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "date_of_birthday" DATETIME NOT NULL,
    "cpf" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "CC" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "NT" TEXT NOT NULL,
    "CN" BIGINT NOT NULL,
    "Validate" TEXT NOT NULL,
    "CVV" INTEGER NOT NULL,
    "userId" TEXT NOT NULL,
    CONSTRAINT "CC_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_cpf_key" ON "User"("cpf");
