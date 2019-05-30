module Funding
  class User
    attr_reader :name
    attr_accessor :pledges

    @@users = []

    def initialize(name)
      @name = name
      @pledges = []
      @@users << self
    end

    def projects
      @pledges.map do |pledge|
        pledge.project.title
      end
    end

    def self.all
      @@users
    end
  end

  class Pledge
    attr_reader :amount, :user, :project

    def initialize(user, amount, project)
      @amount = amount
      @user = user
      @project = project
      user.pledges << self
      project.pledges << self
    end
  end

  class Project
    attr_accessor :title, :pledges

    @@projects = []

    def initialize(title)
      @title = title
      @pledges = []
      @@projects << self
    end

    def self.list
      @@projects
    end
  end
end
