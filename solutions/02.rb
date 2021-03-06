class Task
  attr_accessor :status, :description, :priority, :tags

  def initialize(status, description, priority, tags = nil)
    @status = status.downcase.to_sym
    @description = description
    @priority = priority.downcase.to_sym
    @tags = tags.to_s.split(',').map &:strip
  end
end

class Criteria
  attr_accessor :process

  def initialize(process)
    @process = process
  end

  def Criteria.status(target_status)
    new -> value { value.status == target_status }
  end

  def Criteria.priority(target_priority)
    new -> value { value.priority == target_priority }
  end

  def Criteria.tags(target_tags)
    new -> value { target_tags.size == (value.tags & target_tags).size }
  end

  def &(other)
    Criteria.new -> value { @process.call(value) and other.process.call(value) }
  end

  def |(other)
    Criteria.new -> value { @process.call(value) or other.process.call(value) }
  end

  def !
    Criteria.new -> value { not @process.call(value) }
  end
end

class TodoList
  attr_accessor :task_list
  include Enumerable

  def initialize(list)
    @task_list = list
  end

  def TodoList.parse(text)
    new text.split("\n").map { |row| Task.new(*row.split("|").map(&:strip)) }
  end

  def each
    @task_list.each { |task| yield task}
  end

  def filter(criteria)
    TodoList.new @task_list.select(&criteria.process).compact
  end

  def adjoin(other)
    TodoList.new @task_list | other.task_list
  end

  def tasks_todo
    @task_list.count { |task| task.status == :todo }
  end

  def tasks_in_progress
    @task_list.count { |task| task.status == :current }
  end

  def tasks_completed
    @task_list.count { |task| task.status == :done }
  end

  def completed?
    @task_list.map { |task| task.status == :done }.all?
  end
end