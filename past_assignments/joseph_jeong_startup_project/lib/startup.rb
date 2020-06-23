require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        @salaries.has_key?(title)
    end

    def >(startup)
        @funding > startup.funding
    end

    def hire(employee_name, title)
        if !self.valid_title?(title)
            raise "invalid title"
        else
            new_employee = Employee.new(employee_name, title)
            @employees << new_employee
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        money_owed = @salaries[employee.title]
        if @funding >= money_owed
            @funding -= money_owed
            employee.pay(money_owed)
        else
            raise "insufficient funds"
        end
    end

    def payday
        @employees.each do |employee|
            self.pay_employee(employee)
        end
    end

    def average_salary
        average = 0
        total_employees = @employees.length
        total_salaries = 0

        @employees.each do |employee|
            total_salaries += @salaries[employee.title]
        end

        total_salaries / (total_employees * 1.0)
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(other_startup)
        @funding += other_startup.funding

        other_startup.salaries.each do |title, salary|
            if !valid_title?(title)
                @salaries[title] = salary
            end
        end

        other_startup.employees.each do |employee|
            @employees << employee
        end

        other_startup.close
    end
end
