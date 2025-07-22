-- AddForeignKey
ALTER TABLE "department" ADD CONSTRAINT "department_hod_fkey" FOREIGN KEY ("hod") REFERENCES "staff"("staff_no") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "staff" ADD CONSTRAINT "staff_dept_code_fkey" FOREIGN KEY ("dept_code") REFERENCES "department"("dept_code") ON DELETE RESTRICT ON UPDATE CASCADE;
