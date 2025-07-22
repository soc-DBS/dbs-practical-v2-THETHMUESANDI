/*
  Warnings:

  - The primary key for the `stud_mod_performance` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `student` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `stud_no` on the `student` table. All the data in the column will be lost.
  - Added the required column `admin_no` to the `student` table without a default value. This is not possible if the table is not empty.
  - Added the required column `dob` to the `student` table without a default value. This is not possible if the table is not empty.
  - Added the required column `email` to the `student` table without a default value. This is not possible if the table is not empty.
  - Added the required column `gender` to the `student` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "stud_mod_performance" DROP CONSTRAINT "stud_mod_performance_pkey",
ALTER COLUMN "stud_no" SET DATA TYPE CHAR(8),
ADD CONSTRAINT "stud_mod_performance_pkey" PRIMARY KEY ("stud_no", "mod_code");

-- AlterTable
ALTER TABLE "student" DROP CONSTRAINT "student_pkey",
DROP COLUMN "stud_no",
ADD COLUMN     "admin_no" CHAR(8) NOT NULL,
ADD COLUMN     "dob" DATE NOT NULL,
ADD COLUMN     "email" VARCHAR(100) NOT NULL,
ADD COLUMN     "gender" CHAR(1) NOT NULL,
ALTER COLUMN "stud_name" SET DATA TYPE VARCHAR(100),
ADD CONSTRAINT "student_pkey" PRIMARY KEY ("admin_no");

-- AddForeignKey
ALTER TABLE "stud_mod_performance" ADD CONSTRAINT "stud_mod_perf_stud_no_fk" FOREIGN KEY ("stud_no") REFERENCES "student"("admin_no") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "stud_mod_performance" ADD CONSTRAINT "stud_mod_perf_mod_code_fk" FOREIGN KEY ("mod_code") REFERENCES "module"("mod_code") ON DELETE NO ACTION ON UPDATE NO ACTION;
