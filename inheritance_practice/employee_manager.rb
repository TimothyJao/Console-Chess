class Employee

  attr_reader :name, :salary
  def initialize(name, salary)
    @name = name
    @salary = salary
  end
  def total_salary
    salary
  end
  def bonus(multiplier)
    self.salary*multiplier
  end


end

class Manager < Employee

  attr_reader :employee

  def initialize(name, salary, employee)
    super(name, salary)
    @employee = employee
  end
  def total_salary
    @salary + self.employee.sum { |employee| employee.total_salary }
  end
  def bonus(multiplier)
    multiplier * (total_salary - @salary)
  end
end

david = Employee.new("David", 10000)
shawna = Employee.new("Shawna", 12000)
darren = Manager.new("Darren", 78000, [david, shawna])
ned = Manager.new("Ned", 1000000, [darren])

p ned.bonus(5) # => 500_000
p darren.bonus(4) # => 88_000
p david.bonus(3) # => 30_000