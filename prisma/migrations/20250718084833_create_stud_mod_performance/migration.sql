-- CreateTable
CREATE TABLE "stud_mod_performance" (
    "stud_no" CHAR(4) NOT NULL,
    "mod_code" VARCHAR(10) NOT NULL,
    "exam_score" INTEGER NOT NULL,

    CONSTRAINT "stud_mod_performance_pkey" PRIMARY KEY ("stud_no","mod_code")
);
