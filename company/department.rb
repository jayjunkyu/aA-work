class Employee
    attr_reader :name, :salary, :title
    attr_accessor :boss

    def initialize(name, salary, title, boss = nil)
        @name, @salary, @title = name, salary, title
        self.boss = boss  # boss should be a Manager object
    end

    def boss=(boss)  # this is called upon initialization
        @boss = boss
        boss.add_employee(self) unless boss.nil? # Manager object adds its employee

        boss  # returns back boss to Employee
    end

    def bonus(multiplier)
        self.salary * multiplier
    end
end

class Manager < Employee
    attr_reader :employees

    def initialize(name, salary, title, boss = nil)
        super(name, salary, title, boss)
        @employees = []
    end

    def add_employee(subordinate)
        employees << subordinate

        subordinate
    end

    def bonus(multiplier)
        self.total_subsalary * multiplier
    end

    def total_subsalary
        total_subsalary = 0
        self.employees.each do |employee|
            if employee.is_a?(Manager)  # if object is a Manager, call its total_subsalary
                total_subsalary += employee.salary + employee.total_subsalary
            else  # add employee salary if object is a normal employee
                total_subsalary += employee.salary
            end
        end

        total_subsalary
    end
end


if __FILE__ == $PROGRAM_NAME
    emp1 = Manager.new("Ned", 90000, "Tech Lead")
    emp2 = Employee.new("Park", 60000, "SDE1", emp1)
    puts emp2.bonus(2)  # 120,000
    puts emp2.salary # 60,000
    emp3 = Employee.new("Karen", 70000, "SDE2", emp1)
    puts emp1.bonus(2) # (60,000 + 70,000) * 2 = 260,000
end