-- CreateTable
CREATE TABLE "student" (
    "stud_no" CHAR(4) NOT NULL,
    "stud_name" VARCHAR(50) NOT NULL,
    "crse_code" VARCHAR(5) NOT NULL,
    "nationality" VARCHAR(30) NOT NULL,

    CONSTRAINT "student_pkey" PRIMARY KEY ("stud_no")
);
