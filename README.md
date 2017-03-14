# NHJAX_Database
# Introduction
One of the challenging tasks on any software project is to manage the database changes and keep all changes in sync. The work is tougher when we have multiple test environments or multiple servers in place. Unlike the database changes, managing code changes is easy due to availability of version control. It is a very responsible task for any DBA to keep track of all the changes and deploy these changes to multiple servers. This is quite error prone and needs lots of testing.
We have the above issue until we work with SQL database projects using Visual Studio. We can develop, manage, compare and deploy the database changes using Visual Studio very easily. We can also keep all the database object changes under Gitghub version control.
The SQL database development was present on Visual Studio since VS.NET version 2010 but in 2015, we have many powerful features present. We can create a new database project from an existing database with just a button click or we can create a database project from scratch. For now, let’s see how to create a DB project from scratch. Later, we will show how to create a database project from an existing database.
# Create Database Project on Visual Studio 2015
To create a new SQL server database project, open “New Project” dialog and from there, select SQL Server from the default template. In the right side pane, select SQL server database project and provide the project name. I have given the project name as NHJAX_Database.

