-- AddForeignKey
ALTER TABLE "course" ADD CONSTRAINT "course_offered_by_fkey" FOREIGN KEY ("offered_by") REFERENCES "department"("dept_code") ON DELETE NO ACTION ON UPDATE NO ACTION;
