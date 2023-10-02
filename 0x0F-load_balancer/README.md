# Load balancer
In this project we are going to configure web-02 to be identical to web-01

Then, we gonna add load balancer to distribute requests between them

Since we’re placing our web servers behind a load balancer for this project, we want to add a custom Nginx response header.

The goal here is to be able to track which web server is answering our HTTP requests, to understand and track the way a load balancer works.
