-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "user" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "date_of_birthday" TEXT NOT NULL,
    "cpf" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "CC" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "NT" TEXT NOT NULL,
    "CN" TEXT NOT NULL,
    "Validate" TEXT NOT NULL,
    "CVV" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    CONSTRAINT "CC_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "User_user_key" ON "User"("user");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_cpf_key" ON "User"("cpf");
