require "spec_helper"
require_relative "../lib/funding.rb"

describe "crowdfunder" do
  it "has users" do
    user = Funding::User.new("bob")

    expect(user.name).to eq("bob")
  end

  it "has pledges" do
    user = Funding::User.new("bob")
    save_a_toaster = Funding::Project.new("")
    pledge = Funding::Pledge.new(user, 100, save_a_toaster)

    expect(pledge.amount).to eq(100)
    expect(user.pledges.count).to eq(1)
  end

  it "has projects" do
    title = "My new game"
    project = Funding::Project.new(title)

    expect(project.title).to eq(title)
    expect(project.pledges.count).to eq(0)
  end
  it "lists all projects" do
    expect(Funding::Project.list.is_a? Array).to be(true)
    3.times { |n| Funding::Project.new(n) }
    expect(Funding::Project.list.length).to eq(5)
  end
  it "pledge should have a user" do
    user = Funding::User.new("Tyrion")
    save_a_toaster = Funding::Project.new("")
    pledge = Funding::Pledge.new(user, 100, save_a_toaster)
    expect(pledge.user).to eq(user)
  end
  it "pledge should have a project" do
    project = Funding::Project.new("Flatiron")
    user = Funding::User.new("Joel")
    pledge = Funding::Pledge.new(user, 101, project)
    expect(pledge.project).to eq(project)
  end
  it "pledge should be added to a project" do
    project = Funding::Project.new("Flatiron")
    user = Funding::User.new("Joel")
    pledge = Funding::Pledge.new(user, 101, project)

    expect(project.pledges.include? pledge).to be(true)
  end

  it "lets you access all a specific user's projects" do
    project = Funding::Project.new("Flatiron")
    user = Funding::User.new("Joel")
    pledge = Funding::Pledge.new(user, 101, project)

    project2 = Funding::Project.new("Kingslanding")
    pledge2 = Funding::Pledge.new(user, 10000, project2)

    expect(user.projects.include?("Kingslanding")).to eq(true)
    expect(user.projects.include?("Flatiron")).to eq(true)
  end
end
