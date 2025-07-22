/*
  Warnings:

  - The primary key for the `stud_mod_performance` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `exam_score` on the `stud_mod_performance` table. All the data in the column will be lost.
  - You are about to drop the column `mod_code` on the `stud_mod_performance` table. All the data in the column will be lost.
  - You are about to drop the column `stud_no` on the `stud_mod_performance` table. All the data in the column will be lost.
  - The primary key for the `student` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `admin_no` on the `student` table. All the data in the column will be lost.
  - You are about to drop the column `email` on the `student` table. All the data in the column will be lost.
  - You are about to alter the column `stud_name` on the `student` table. The data in that column could be lost. The data in that column will be cast from `VarChar(100)` to `VarChar(30)`.
  - Added the required column `adm_no` to the `stud_mod_performance` table without a default value. This is not possible if the table is not empty.
  - Added the required column `mod_registered` to the `stud_mod_performance` table without a default value. This is not possible if the table is not empty.
  - Added the required column `address` to the `student` table without a default value. This is not possible if the table is not empty.
  - Added the required column `adm_no` to the `student` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "department" DROP CONSTRAINT "department_hod_fkey";

-- DropForeignKey
ALTER TABLE "staff" DROP CONSTRAINT "staff_dept_code_fkey";

-- DropForeignKey
ALTER TABLE "stud_mod_performance" DROP CONSTRAINT "stud_mod_perf_mod_code_fk";

-- DropForeignKey
ALTER TABLE "stud_mod_performance" DROP CONSTRAINT "stud_mod_perf_stud_no_fk";

-- AlterTable
ALTER TABLE "stud_mod_performance" DROP CONSTRAINT "stud_mod_performance_pkey",
DROP COLUMN "exam_score",
DROP COLUMN "mod_code",
DROP COLUMN "stud_no",
ADD COLUMN     "adm_no" CHAR(4) NOT NULL,
ADD COLUMN     "grade" CHAR(2),
ADD COLUMN     "mark" INTEGER,
ADD COLUMN     "mod_registered" VARCHAR(10) NOT NULL,
ADD CONSTRAINT "stud_mod_performance_pkey" PRIMARY KEY ("adm_no", "mod_registered");

-- AlterTable
ALTER TABLE "student" DROP CONSTRAINT "student_pkey",
DROP COLUMN "admin_no",
DROP COLUMN "email",
ADD COLUMN     "address" VARCHAR(100) NOT NULL,
ADD COLUMN     "adm_no" CHAR(4) NOT NULL,
ADD COLUMN     "home_phone" CHAR(8),
ADD COLUMN     "mobile_phone" CHAR(8),
ALTER COLUMN "stud_name" SET DATA TYPE VARCHAR(30),
ADD CONSTRAINT "student_pkey" PRIMARY KEY ("adm_no");

-- RenameForeignKey
ALTER TABLE "course" RENAME CONSTRAINT "course_offered_by_fkey" TO "course_offered_by_fk";

-- AddForeignKey
ALTER TABLE "department" ADD CONSTRAINT "dept_hod_fk" FOREIGN KEY ("hod") REFERENCES "staff"("staff_no") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "staff" ADD CONSTRAINT "staff_dept_code_fk" FOREIGN KEY ("dept_code") REFERENCES "department"("dept_code") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "stud_mod_performance" ADD CONSTRAINT "stud_mod_performance_adm_no_fkey" FOREIGN KEY ("adm_no") REFERENCES "student"("adm_no") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "stud_mod_performance" ADD CONSTRAINT "stud_mod_performance_mod_registered_fkey" FOREIGN KEY ("mod_registered") REFERENCES "module"("mod_code") ON DELETE NO ACTION ON UPDATE NO ACTION;
