# ecommerce_mobile

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

