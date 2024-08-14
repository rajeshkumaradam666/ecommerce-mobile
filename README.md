# ecommerce-mobile
A sample application with login and signup page. once enter into the application able to see the products list.

Ecommerce Mobile App
--------------------------
sample login credentials :
Email - rajesh@gmail.com
Password - 123456
--------------------------

Flutter Version Used : 3.0.1
Dart : 2.17.1

Screens :
----------
Splash Screen
Login Screen
Signup Screen
Product Details Screen
--------------------
Logics
-------
1. Firebase Authentication: using this for login with email and password.
2. User Details Collection: Details collected and stored in firebase database under users collection.
3. Product Feed: Display a feed showing all products.
4. Price Display Logic: Using Firebase Remote Config to determine whether to display the
   discounted price or the original price. If the boolean value in Remote Config is true, calculate
   and displaying the discounted price using the discount percentage for each product; otherwise,
   displaying the original price.
5. Validations : validation and error handling code added.

Screen shots :
---------------
(https://github.com/user-attachments/assets/bedd8054-8262-4701-a532-b5f957594a4b)
(https://github.com/user-attachments/assets/7db12a7d-2a60-492c-8044-d74bc20d5145)
(https://github.com/user-attachments/assets/4474cca5-2026-4606-a415-3d11c777d330)




