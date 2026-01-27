# java-project
e-commerce website which using all the concept of jdbc servlet design pattern and all other...


Project Type

Full Semester Java Web Application Project

📌 Project Title

Online Order Management System using MVC Architecture

📖 Project Description

The Online Order Management System is a web-based Java application designed to manage the complete lifecycle of an online order, starting from user authentication and product browsing to order placement, tracking, and delivery status updates.

The system provides two roles: User (Customer) and Admin.
Users can log in securely, view available products, place orders, and track their order status.
Admins can manage products, view all customer orders, and update order statuses.

The application is developed using Jakarta Servlets and JSP by strictly following the MVC (Model–View–Controller) design pattern.
JDBC is used for database communication with MySQL, and Session Management ensures secure authentication and user tracking throughout the application.

🎯 Objectives of the Project

To automate the order placement and order tracking process

To implement secure authentication using session management

To efficiently manage products and customer orders

To demonstrate real-world use of MVC architecture

To apply core Java web technologies used in the industry

👥 User Roles
🔹 User (Customer)

Login / Logout

View product list

Place orders

Track order status

View order history

🔹 Admin

Login / Logout

Add new products

Update product details

Delete products

View all customer orders

Update order status (Placed, Shipped, Delivered, Cancelled)

🧩 Functional Modules

1️⃣ Authentication Module

User login

Admin login

Session creation after successful login

Session validation for secured pages

Logout and session destruction

2️⃣ Product Management Module

Add products (Admin)

Update products (Admin)

Delete products (Admin)

View product list (User & Admin)

3️⃣ Order Management Module

Place order

Generate unique order ID

Store order and order items in database

Update order status

4️⃣ Order Tracking Module

View current order status

View complete order history

🏗 MVC Architecture Implementation

This project strictly follows MVC Design Pattern:

M – Model (Java Beans)

UserBean – Stores user details

ProductBean – Stores product information

OrderBean – Stores order details

OrderItemBean – Stores ordered product details

JavaBeans are used to encapsulate data, follow getter/setter methods, and are accessed by Servlets and JSP.

V – View (JSP Pages)

login.jsp

register.jsp

productList.jsp

placeOrder.jsp

orderStatus.jsp

orderHistory.jsp

adminDashboard.jsp

JSP pages are used only for presentation logic and receive data via request/session scope.

C – Controller (Jakarta Servlets)

LoginServlet

LogoutServlet

ProductServlet

OrderServlet

OrderStatusServlet

Servlets handle:

Client requests

Business logic

Interaction with JavaBeans and JDBC

Navigation using RequestDispatcher and sendRedirect()

🔀 Navigation Techniques Used

RequestDispatcher

Used to forward requests from Servlet to JSP

Example:

LoginServlet → productList.jsp

sendRedirect()

Used after logout or critical actions

Prevents form resubmission

🗄 Database Design
java database connectivity 


Tables Used


1️⃣ users

user_id (Primary Key)

name

email

password

role

2️⃣ products

product_id (Primary Key)

product_name

price

quantity

3️⃣ orders

order_id (Primary Key)

user_id (Foreign Key)

order_date

status

4️⃣ order_items

order_item_id (Primary Key)

order_id (Foreign Key)

product_id (Foreign Key)

quantity

price

📌 ER Diagram is used to represent relationships between users, orders, products, and order items.



🔐 Session Management

Session is created after successful login

User ID and role are stored in session

Session validation is performed before accessing secured pages

Session is destroyed on logout

🛠 Technology Stack Used
Server-Side Technologies

Jakarta Servlet

Jakarta Server Pages (JSP)

Database & Connectivity

JDBC

MySQL

Web Technologies

HTML5

CSS

Other Core Concepts

Java Beans

Session Management

RequestDispatcher

sendRedirect()

MVC Design Pattern

ER Diagram

✅ Mandatory Checklist (Faculty Friendly)
Requirement	Used
Jakarta Servlet	✔
JSP	✔
JDBC	✔
MySQL	✔
HTML & CSS	✔
Java Bean	✔
MVC Architecture	✔
RequestDispatcher	✔
sendRedirect()	✔
Session Management	✔
ER Diagram	✔
🎓 Viva One-Line Explanation

“This project implements a complete online order processing system using MVC architecture, where Servlets act as controllers, JSP pages serve as views, JavaBeans represent models, JDBC handles database interaction with MySQL, and session management ensures secure user authentication.”

🏁 Conclusion

The Online Order Management System is a classic, well-structured Java web application that demonstrates all essential concepts required for a full-semester academic project.
It follows clean MVC separation, uses industry-relevant technologies, and is easy to explain during viva, making it a high-scoring and faculty-approved project.
