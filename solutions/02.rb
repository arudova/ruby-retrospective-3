class TodoList
 
  include Enumerable
 
  attr_accessor :tasks_list
 
  def each
    @tasks_list.each { |task| yield task }
  end
 
  def self.parse(text)
    TodoList.new(text)
  end
 
  def initialize(text)
    @tasks_list = []
    text.each_line do |line|
      @tasks_list << Task.new(line)
    end
    @tasks_list
  end
 
  def filter(criteria)
  end
 
  def adjoin(todo_list)
  end
 
  def tasks_todo
    @tasks_list.select { |task| task.status == :TODO }.size
  end
 
  def tasks_in_progress
    @tasks_list.select { |task| task.status == :CURRENT }.size
  end
 
  def tasks_completed
    @tasks_list.select { |task| task.status == :DONE }.size
  end
 
  def completed?
    @tasks_list.all? { |task| task.status == :DONE }
  end
end
 
class Task
  attr_accessor :todo_list_line
 
  def initialize(line)
    @todo_list_line = []
    line.split('|').each { |substring| @todo_list_line << substring.strip }
    self
  end
 
  def status
    @todo_list_line[0].to_sym
  end
 
  def description
    @todo_list_line[1]
  end
 
  def priority
    @todo_list_line[2].to_sym
  end
 
  def tags
    @todo_list_line[3].split ", "
  end
end
 
class Criteria
 
  attr_accessor :task
 
  def initialize(task)
    @task = task
  end
 
  class << self
    def status(task_status)
      @task.status == task_status
    end
 
    def priority(task_priority)
      @task.priority == task_priority
    end
 
    def tags(task_tags)
      @task.tags.member? task_tags
    end
 
    def &(other_crit)
    end
 
    def |(other_crit)
    end
 
    def !
    end
  end
end