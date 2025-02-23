class School
  def initialize
    @students = {}
  end

  def add(name, grade)
    grade_students = students(grade)
    grade_students.push(name)
    @students[grade] = grade_students.sort
    @students = @students.sort.to_h
  end

  def students_by_grade
    @students.map do |grade, grade_students|
      { grade: grade, students: grade_students}
    end
  end

  def students(grade)
    @students.fetch(grade, [])
  end
end
