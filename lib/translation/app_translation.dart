import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    // ============================================================
    // ENGLISH
    // ============================================================
    'en_US': {
      // ----------------------------------------------------------
      // Navigation
      // ----------------------------------------------------------
      'home': 'Home',
      'categories': 'Categories',
      'wishlist': 'Wishlist',
      'cart': 'Cart',
      'profile': 'Profile',

      // ----------------------------------------------------------
      // Settings
      // ----------------------------------------------------------
      'settings': 'Settings',
      'preferences': 'Preferences',

      'dark_mode': 'Dark Mode',
      'enable_dark_mode': 'Enable dark appearance',

      'notifications': 'Notifications',
      'view_notifications': 'View all notifications',

      'account_legal': 'Account & Legal',

      'change_password': 'Change Password',
      'update_password': 'Update your password',

      'privacy': 'Privacy Policy',
      'privacy_subtitle': 'Read our privacy policy',

      'terms': 'Terms & Conditions',
      'terms_subtitle': 'Read terms of use',

      'language': 'Language',
      'choose_language': 'Choose your preferred language',

      'english': 'English',
      'nepali': 'Nepali',

      // ----------------------------------------------------------
      // Common
      // ----------------------------------------------------------
      'back': 'Back',
      'remove': 'Remove',
      'save': 'Save',
      'cancel': 'Cancel',
      'continue_shopping': 'Continue Shopping',

      // ----------------------------------------------------------
      // Messages
      // ----------------------------------------------------------
      'success': 'Success',
      'error': 'Error',

      'all_notifications_marked': 'All notifications marked as read',
      'Unread_notifications': 'Unread notifications',
      'Unread': 'Unread',
      'read': 'Read',
      'new_messages': 'new messages',
      'no_notifications': 'No notifications',
      'you_are_all_caught_up': "You're all caught up.",
      'refresh': 'Refresh',
      'Mark all': 'Mark all',
      'mark_as_read': 'Mark as read',
      'mark_as_unread': 'Mark as unread',
      'Just now': 'Just now',
      'Yesterday': 'Yesterday',
      'minutes_ago': 'minutes ago',
      'hours_ago': 'hours ago',
      'days_ago': 'days ago',

      'fill_all_fields': 'Please fill all fields',
      'password_not_match': 'Passwords do not match',
      'password_changed': 'Password changed successfully',

      // ----------------------------------------------------------
      // Profile
      // ----------------------------------------------------------
      'edit_profile': 'Edit Profile',
      'my_orders': 'My Orders',
      'logout': 'Logout',
      'logout_title': 'Logout',
      'logout_confirmation': 'Are you sure you want to logout?',

      // ----------------------------------------------------------
      // Home
      // ----------------------------------------------------------
      'welcome_to': 'Welcome to',
      'hello': 'Hello',
      'greetings': 'Greetings!',
      'search_products': 'Search products',

      'all': 'All',
      'fashion': 'Fashion',
      'wearables': 'Wearables',
      'shoes': 'Shoes',
      'smartphones': 'Smartphones',

      'featured': 'Featured',
      'top_picks': 'Top Picks',
      'for_you': 'For You',

      // ----------------------------------------------------------
      // Cart
      // ----------------------------------------------------------
      'my_cart': 'My Cart',
      'select_all': 'Select all',
      'deselect_all': 'Deselect all',
      'selected': 'selected',
      'checkout': 'Checkout',
      'select_items_checkout': 'Select items to checkout',
      'empty_cart': 'Your cart is empty',
      'empty_cart_description': 'Products you add will appear here.',

      // ----------------------------------------------------------
      // Payment
      // ----------------------------------------------------------
      'payment': 'Payment',
      'select_payment_method': 'Select Payment Method',
      'payment_method_description':
          'Choose how you would like to complete your order.',
      'cash_on_delivery': 'Cash on Delivery',
      'amount': 'Amount',
      'pay_now': 'PAY NOW',

      // Shared storefront text
      'try_again': 'Try again',
      'try_again_caps': 'Try Again',
      'please_wait': 'Please wait...',
      'show_more': 'Show more',
      'show_all': 'Show all',
      'load_products': 'Load products',
      'end_reached': "You've reached the end 🎉",
      'no_products_available': 'No products are available.',
      'no_products_found': 'No Products Found',
      'no_categories_available': 'No categories are available',
      'all_categories': 'All Categories',
      'no_products': 'No products',
      'one_product': '1 product',
      'products_count': '@count products',
      'items_count': '@count items',
      'selected_count': '@count selected',
      'subtotal_shipping': 'Subtotal Rs. @subtotal + shipping Rs. @shipping',
      'use_light_mode': 'Use light mode',
      'use_dark_mode': 'Use dark mode',
      'electronics': 'Electronics',
      'books': 'Books',
      'clothing': 'Clothing',
      'home_garden': 'Home & Garden',
      'sports': 'Sports',
      'general': 'General',
      'added_to_wishlist': 'Added to wishlist',
      'unable_add_wishlist': 'Unable to add to wishlist',
      'wishlist_empty': 'Your wishlist is empty',
      'my_wishlist': 'My Wishlist',
      'wishlist_empty_description': 'Products you save will appear here.',
      'wishlist_category_empty': 'No products in this category',
      'wishlist_category_empty_description':
          'Choose another category to view your saved products.',
      'product_details': 'Product Details',
      'product_details_unavailable': 'Product details are unavailable.',
      'description': 'Description',
      'select_size': 'Select Size',
      'select_color': 'Select Color',
      'add_to_cart': 'ADD TO CART',
      'buy_now': 'BUY NOW',
      'out_of_stock': 'Out of stock',
      'reviews': 'Reviews',
      'details': 'Details',
      'remove_from_wishlist': 'Remove from wishlist',
      'add_to_wishlist': 'Add to wishlist',
      'no_description': 'No description available.',
      'read_less': 'Read less',
      'read_more': 'Read more',
      'free_delivery': 'Free Delivery',
      'delivery_inside_valley': 'Inside Valley\n2–3 days',
      'original_products': '100% Original',
      'authentic_products': 'Authentic\nproducts',
      'easy_returns': 'Easy Returns',
      'returns_description': 'Within 7 days\nof delivery',
      'adding': 'Adding...',
      'subtotal': 'Subtotal',
      'shipping': 'Shipping',
      'total': 'Total',
      'color': 'Color',
      'size': 'Size',
      'remove_item': 'Remove item?',
      'remove_selected_items': 'Remove selected items?',
      'remove_cart_description':
          'The selected products will be removed from your cart.',
      'cart_cleared': 'Cart cleared',
      'unable_clear_cart': 'Unable to clear cart',
      'all_orders': 'All Orders',
      'to_pay': 'To Pay',
      'processing': 'Processing',
      'to_ship': 'To Ship',
      'to_receive': 'To Receive',
      'return_refund': 'Return/Refund',
      'to_review': 'To Review',
      'order_history': 'Order History',
      'search_order': 'Search by order ID or product',
      'no_orders_found': 'No orders found',
      'orders_appear_here': 'Your orders will appear here.',
      'cancel_order_question': 'Cancel order?',
      'cancel_order_number': 'Cancel order #@number?',
      'keep_order': 'Keep order',
      'cancel_order': 'Cancel Order',
      'view_details': 'View Details',
      'track_order': 'Track Order',
      'review': 'Review',
      'order_successful': 'Order Successful!',
      'order_success_description': 'Your order has been placed successfully.',
      'view_orders': 'VIEW ORDERS',
      'set_delivery_address': 'Set your delivery address',
      'address_setup_description':
          'ShopEase needs one delivery address before you start shopping. You can change it later from Edit Profile.',
      'address_line_1': 'Address line 1',
      'address_line_2_optional': 'Address line 2 (optional)',
      'city': 'City',
      'state_province': 'State / Province',
      'zip_postal_code': 'ZIP / Postal code',
      'country': 'Country',
      'save_continue': 'SAVE AND CONTINUE',
      'saving_address': 'SAVING ADDRESS...',
      'required_field': '@field is required',
      'search_products_title': 'Search Products',
      'apply': 'Apply',
      'category': 'Category',
      'price': 'Price',
      'rating': 'Rating',
      'clear': 'Clear',
      'minimum_price': 'Minimum Price',
      'maximum_price': 'Maximum Price',
      'minimum_rating': 'Minimum Rating (0 - 5)',
      'maximum_rating': 'Maximum Rating (0 - 5)',
      'login': 'Login',
      'welcome_back': 'Welcome Back',
      'email': 'Email',
      'password': 'Password',
      'forgot_password': 'Forgot Password?',
      'sign_in': 'SIGN IN',
      'sign_up': 'SIGN UP',
      'create_account': 'Create Account',
      'full_name': 'Full Name',
      'phone_number': 'Phone Number',
      'enter_password': 'Enter your password',
      'remember_me': 'Remember Me',
      'logging_in': 'Logging in...',
      'no_account': "Don't have an account?",
      'register': 'REGISTER',
      'confirm_your_password': 'Confirm your password',
      'password_strength_hint':
          'Use at least 8 characters with uppercase, lowercase and a number.',
      'creating_account': 'Creating Account...',
      'already_have_account': 'Already have an account?',
      'continue': 'CONTINUE',
      'unavailable': 'Unavailable',
      'order_id': 'Order ID:',
      'thank_you_order_success':
          'Thank you! Your order has been placed successfully.',
      'change_profile_picture': 'Change Profile Picture',
      'take_photo': 'Take Photo',
      'choose_gallery': 'Choose from Gallery',
      'remove_selected_photo': 'Remove Selected Photo',
      'name': 'Name',
      'enter_name': 'Enter your name',
      'enter_email': 'Enter your email address',
      'enter_phone': 'Enter your phone number',
      'address': 'Address',
      'no_address_added': 'No address added',
      'address_line_2': 'Address Line 2',
      'street_address_hint': 'Street address or house number',
      'apartment_hint': 'Apartment, floor or landmark',
      'enter_city': 'Enter your city',
      'enter_state': 'Enter your state or province',
      'enter_zip': 'Enter ZIP or postal code',
      'enter_country': 'Enter your country',
      'saving': 'Saving...',
      'save_changes': 'Save Changes',
      'change_photo': 'Change Photo',
      'confirm_order': 'Confirm Your Order',
      'payment_title': '@method Payment',
      'place_order': 'PLACE ORDER',
      'continue_to_gateway': 'CONTINUE TO @gateway',
      'continue_to_payment': 'CONTINUE TO PAYMENT',
      'payable_amount': 'Payable Amount',
      'secure_checkout': 'Secure sandbox checkout',
      'cod_pay_delivery': 'You will pay when your order is delivered.',
      'secure_checkout_description':
          'Your wallet details, password, PIN and OTP will be entered only inside the official @method sandbox checkout.',
      'cod_instruction':
          'Your order will be placed using Cash on Delivery. You can pay when the order arrives.',
      'khalti_instruction':
          'You will be redirected securely to Khalti Sandbox to complete your payment.',
      'esewa_instruction':
          'You will be redirected securely to eSewa Sandbox to complete your payment.',
      'order_details': 'Order Details',
      'products': 'Products',
      'shipping_fee': 'Shipping Fee',
      'view_order_tracking': 'View order tracking',
      'buy_again': 'Buy Again',
      'order_not_found': 'Order not found',
      'unable_load_wishlist': 'Unable to load your wishlist.',
      'something_went_wrong': 'Something went wrong.',
      'item_removed_wishlist': 'Item removed from wishlist',
      'failed_remove_item': 'Failed to remove item',
      'unable_load_categories': 'Unable to load categories. Please try again.',
      'unable_load_products': 'Products could not be loaded. Please try again.',

      // ----------------------------------------------------------
      // CHANGE PASSWORD
      // ----------------------------------------------------------
      "update_your_password": "Update Password",
      "current_password": "Current Password",
      "enter_current_password": "Enter current password",
      "new_password": "New Password",
      "enter_new_password": "Enter new password",
      "confirm_password": "Confirm Password",
      "confirm_new_password": "Confirm new password",
      "password_requirement": "Password must be at least 8 characters.",

      // ----------------------------------------------------------
      // PRIVACY POLICY
      // ----------------------------------------------------------
      'privacy_content': '''
PRIVACY POLICY

Last Updated: January 1, 2026

Welcome to our application. Your privacy is important to us. This Privacy Policy explains how we collect, use, store, and protect your information while you use our application.

1. Information We Collect

We may collect the following information:

• Your name
• Email address
• Phone number
• Profile information
• Device information
• App usage statistics

2. How We Use Your Information

We use your information to:

• Create and manage your account.
• Improve our services.
• Provide customer support.
• Send important notifications.
• Ensure application security.
• Analyze application performance.

3. Data Security

We take reasonable security measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction.

4. Information Sharing

We do not sell your personal information. We may share information only:

• When required by law.
• To protect our legal rights.
• With trusted service providers.

5. Cookies and Analytics

Our application may use cookies and analytics tools to improve user experience and understand application usage.

6. Your Rights

You have the right to:

• Access your information.
• Correct inaccurate information.
• Delete your account.
• Request a copy of your data.
• Withdraw your consent.

7. Children's Privacy

Our application is not intended for children under the applicable legal age. We do not knowingly collect information from children.

8. Third-Party Services

Our application may contain links or integrations with third-party services. We are not responsible for their privacy practices.

9. Changes to This Policy

We may update this Privacy Policy from time to time. Updated versions will be available within the application.

10. Contact Us

If you have any questions regarding this Privacy Policy, please contact us through our official support channels.

Thank you for using our application.
''',

      // ----------------------------------------------------------
      // TERMS
      // ----------------------------------------------------------
      'terms_content': '''
1. Use the application responsibly.

2. Respect user privacy.

3. Unauthorized access is prohibited.

4. Application content may change.

5. By using this app you agree to all terms.
''',
    },

    // ============================================================
    // NEPALI
    // ============================================================
    'ne_NP': {
      // ----------------------------------------------------------
      // Navigation
      // ----------------------------------------------------------
      'home': 'गृहपृष्ठ',
      'categories': 'श्रेणीहरू',
      'wishlist': 'इच्छासूची',
      'cart': 'कार्ट',
      'profile': 'प्रोफाइल',

      // ----------------------------------------------------------
      // Settings
      // ----------------------------------------------------------
      'settings': 'सेटिङहरू',
      'preferences': 'प्राथमिकताहरू',

      'dark_mode': 'डार्क मोड',
      'enable_dark_mode': 'डार्क मोड सक्षम गर्नुहोस्',

      'notifications': 'सूचनाहरू',
      'view_notifications': 'सबै सूचनाहरू हेर्नुहोस्',

      'account_legal': 'खाता तथा कानुनी',

      'change_password': 'पासवर्ड परिवर्तन गर्नुहोस्',
      'update_password': 'आफ्नो पासवर्ड अद्यावधिक गर्नुहोस्',

      'update_your_password': 'आफ्नो पासवर्ड अद्यावधिक गर्नुहोस्',

      'privacy': 'गोपनीयता नीति',
      'privacy_subtitle': 'हाम्रो गोपनीयता नीति पढ्नुहोस्',

      'terms': 'नियम तथा सर्तहरू',
      'terms_subtitle': 'प्रयोगका नियम तथा सर्तहरू पढ्नुहोस्',

      'language': 'भाषा',
      'choose_language': 'आफ्नो मनपर्ने भाषा छनोट गर्नुहोस्',

      'english': 'अंग्रेजी',
      'nepali': 'नेपाली',

      // ----------------------------------------------------------
      // Common
      // ----------------------------------------------------------
      'back': 'पछाडि',
      'remove': 'हटाउनुहोस्',
      'save': 'सेभ गर्नुहोस्',
      'cancel': 'रद्द गर्नुहोस्',
      'continue_shopping': 'किनमेल जारी राख्नुहोस्',

      // ----------------------------------------------------------
      // Messages
      // ----------------------------------------------------------
      'success': 'सफल',
      'error': 'त्रुटि',

      'all_notifications_marked': 'सबै सूचनाहरू पढिएको रूपमा चिन्ह लगाइयो',
      'Unread_notifications': 'नपढिएका सूचनाहरू',
      'Unread': 'नपढिएको',
      'read': 'पढिएको',
      'new_messages': 'नयाँ सन्देशहरू',
      'no_notifications': 'कुनै सूचना छैन',
      'you_are_all_caught_up': 'तपाईंले सबै सूचनाहरू हेरिसक्नुभयो।',
      'refresh': 'ताजा गर्नुहोस्',
      'Mark all': 'सबै चिन्ह लगाउनुहोस्',
      'mark_as_read': 'पढिएको रूपमा चिन्ह लगाउनुहोस्',
      'mark_as_unread': 'नपढिएको रूपमा चिन्ह लगाउनुहोस्',
      'Just now': 'भर्खरै',
      'Yesterday': 'हिजो',
      'minutes_ago': 'मिनेट अघि',
      'hours_ago': 'घण्टा अघि',
      'days_ago': 'दिन अघि',

      'fill_all_fields': 'कृपया सबै विवरण भर्नुहोस्',

      'password_not_match': 'पासवर्डहरू मिलेनन्',

      'password_changed': 'पासवर्ड सफलतापूर्वक परिवर्तन भयो',

      // ----------------------------------------------------------
      // Profile
      // ----------------------------------------------------------
      'edit_profile': 'प्रोफाइल सम्पादन गर्नुहोस्',

      'my_orders': 'मेरा अर्डरहरू',

      'logout': 'लगआउट',

      'logout_title': 'लगआउट',

      'logout_confirmation': 'के तपाईं लगआउट गर्न निश्चित हुनुहुन्छ?',

      // ----------------------------------------------------------
      // Home
      // ----------------------------------------------------------
      'welcome_to': 'स्वागत छ',
      'hello': 'नमस्कार',
      'greetings': 'अभिवादन!',
      'search_products': 'उत्पादन खोज्नुहोस्',

      'all': 'सबै',
      'fashion': 'फेसन',
      'wearables': 'लगाउन मिल्ने उपकरण',
      'shoes': 'जुत्ता',
      'smartphones': 'स्मार्टफोन',

      'featured': 'विशेष',
      'top_picks': 'उत्कृष्ट छनोट',
      'for_you': 'तपाईंका लागि',

      // ----------------------------------------------------------
      // Cart
      // ----------------------------------------------------------
      'my_cart': 'मेरो कार्ट',
      'select_all': 'सबै चयन गर्नुहोस्',
      'deselect_all': 'सबै चयन हटाउनुहोस्',

      'selected': 'चयन गरिएको',
      'checkout': 'चेकआउट',

      'select_items_checkout': 'चेकआउटका लागि उत्पादन चयन गर्नुहोस्',

      'empty_cart': 'तपाईंको कार्ट खाली छ',

      'empty_cart_description': 'तपाईंले थपेका उत्पादनहरू यहाँ देखिनेछन्।',

      // ----------------------------------------------------------
      // Payment
      // ----------------------------------------------------------
      'payment': 'भुक्तानी',

      'select_payment_method': 'भुक्तानी विधि चयन गर्नुहोस्',

      'payment_method_description':
          'अर्डर पूरा गर्न भुक्तानी विधि छनोट गर्नुहोस्।',

      'cash_on_delivery': 'डेलिभरीमा नगद',

      'amount': 'रकम',

      'pay_now': 'अहिले भुक्तानी गर्नुहोस्',

      // Shared storefront text
      'try_again': 'फेरि प्रयास गर्नुहोस्',
      'try_again_caps': 'फेरि प्रयास गर्नुहोस्',
      'please_wait': 'कृपया पर्खनुहोस्...',
      'show_more': 'थप देखाउनुहोस्',
      'show_all': 'सबै देखाउनुहोस्',
      'load_products': 'उत्पादनहरू लोड गर्नुहोस्',
      'end_reached': 'तपाईं अन्त्यमा पुग्नुभयो 🎉',
      'no_products_available': 'कुनै उत्पादन उपलब्ध छैन।',
      'no_products_found': 'कुनै उत्पादन फेला परेन',
      'no_categories_available': 'कुनै श्रेणी उपलब्ध छैन',
      'all_categories': 'सबै श्रेणीहरू',
      'no_products': 'कुनै उत्पादन छैन',
      'one_product': '१ उत्पादन',
      'products_count': '@count उत्पादनहरू',
      'items_count': '@count वस्तुहरू',
      'selected_count': '@count चयन गरिएको',
      'subtotal_shipping': 'उप-जम्मा रु. @subtotal + ढुवानी रु. @shipping',
      'use_light_mode': 'उज्यालो मोड प्रयोग गर्नुहोस्',
      'use_dark_mode': 'डार्क मोड प्रयोग गर्नुहोस्',
      'electronics': 'इलेक्ट्रोनिक्स',
      'books': 'पुस्तकहरू',
      'clothing': 'लुगा',
      'home_garden': 'घर तथा बगैँचा',
      'sports': 'खेलकुद',
      'general': 'सामान्य',
      'added_to_wishlist': 'इच्छासूचीमा थपियो',
      'unable_add_wishlist': 'इच्छासूचीमा थप्न सकिएन',
      'wishlist_empty': 'तपाईंको इच्छासूची खाली छ',
      'my_wishlist': 'मेरो इच्छासूची',
      'wishlist_empty_description':
          'तपाईंले सुरक्षित गरेका उत्पादनहरू यहाँ देखिनेछन्।',
      'wishlist_category_empty': 'यस श्रेणीमा कुनै उत्पादन छैन',
      'wishlist_category_empty_description':
          'सुरक्षित उत्पादन हेर्न अर्को श्रेणी छान्नुहोस्।',
      'product_details': 'उत्पादन विवरण',
      'product_details_unavailable': 'उत्पादन विवरण उपलब्ध छैन।',
      'description': 'विवरण',
      'select_size': 'साइज छान्नुहोस्',
      'select_color': 'रङ छान्नुहोस्',
      'add_to_cart': 'कार्टमा थप्नुहोस्',
      'buy_now': 'अहिले किन्नुहोस्',
      'out_of_stock': 'स्टकमा छैन',
      'reviews': 'समीक्षाहरू',
      'details': 'विवरण',
      'remove_from_wishlist': 'इच्छासूचीबाट हटाउनुहोस्',
      'add_to_wishlist': 'इच्छासूचीमा थप्नुहोस्',
      'no_description': 'विवरण उपलब्ध छैन।',
      'read_less': 'कम पढ्नुहोस्',
      'read_more': 'थप पढ्नुहोस्',
      'free_delivery': 'निःशुल्क डेलिभरी',
      'delivery_inside_valley': 'उपत्यकाभित्र\n२–३ दिन',
      'original_products': '१००% सक्कली',
      'authentic_products': 'प्रामाणिक\nउत्पादनहरू',
      'easy_returns': 'सजिलो फिर्ता',
      'returns_description': 'डेलिभरीको ७ दिनभित्र',
      'adding': 'थपिँदैछ...',
      'subtotal': 'उप-जम्मा',
      'shipping': 'ढुवानी',
      'total': 'जम्मा',
      'color': 'रङ',
      'size': 'साइज',
      'remove_item': 'वस्तु हटाउने?',
      'remove_selected_items': 'चयन गरिएका वस्तु हटाउने?',
      'remove_cart_description': 'चयन गरिएका उत्पादनहरू कार्टबाट हटाइनेछन्।',
      'cart_cleared': 'कार्ट खाली गरियो',
      'unable_clear_cart': 'कार्ट खाली गर्न सकिएन',
      'all_orders': 'सबै अर्डर',
      'to_pay': 'भुक्तानी गर्न बाँकी',
      'processing': 'प्रक्रियामा',
      'to_ship': 'पठाउन बाँकी',
      'to_receive': 'प्राप्त गर्न बाँकी',
      'return_refund': 'फिर्ता/रिफन्ड',
      'to_review': 'समीक्षा गर्न बाँकी',
      'order_history': 'अर्डर इतिहास',
      'search_order': 'अर्डर आईडी वा उत्पादन खोज्नुहोस्',
      'no_orders_found': 'कुनै अर्डर फेला परेन',
      'orders_appear_here': 'तपाईंका अर्डरहरू यहाँ देखिनेछन्।',
      'cancel_order_question': 'अर्डर रद्द गर्ने?',
      'cancel_order_number': 'अर्डर #@number रद्द गर्ने?',
      'keep_order': 'अर्डर राख्नुहोस्',
      'cancel_order': 'अर्डर रद्द गर्नुहोस्',
      'view_details': 'विवरण हेर्नुहोस्',
      'track_order': 'अर्डर ट्र्याक गर्नुहोस्',
      'review': 'समीक्षा',
      'order_successful': 'अर्डर सफल भयो!',
      'order_success_description': 'तपाईंको अर्डर सफलतापूर्वक राखियो।',
      'view_orders': 'अर्डरहरू हेर्नुहोस्',
      'set_delivery_address': 'डेलिभरी ठेगाना राख्नुहोस्',
      'address_setup_description':
          'किनमेल सुरु गर्नुअघि ShopEase लाई डेलिभरी ठेगाना चाहिन्छ। पछि प्रोफाइल सम्पादनबाट परिवर्तन गर्न सक्नुहुन्छ।',
      'address_line_1': 'ठेगाना लाइन १',
      'address_line_2_optional': 'ठेगाना लाइन २ (वैकल्पिक)',
      'city': 'सहर',
      'state_province': 'प्रदेश',
      'zip_postal_code': 'हुलाक कोड',
      'country': 'देश',
      'save_continue': 'सेभ गरेर अगाडि बढ्नुहोस्',
      'saving_address': 'ठेगाना सेभ हुँदैछ...',
      'required_field': '@field आवश्यक छ',
      'search_products_title': 'उत्पादन खोज्नुहोस्',
      'apply': 'लागू गर्नुहोस्',
      'category': 'श्रेणी',
      'price': 'मूल्य',
      'rating': 'रेटिङ',
      'clear': 'खाली गर्नुहोस्',
      'minimum_price': 'न्यूनतम मूल्य',
      'maximum_price': 'अधिकतम मूल्य',
      'minimum_rating': 'न्यूनतम रेटिङ (० - ५)',
      'maximum_rating': 'अधिकतम रेटिङ (० - ५)',
      'login': 'लगइन',
      'welcome_back': 'पुनः स्वागत छ',
      'email': 'इमेल',
      'password': 'पासवर्ड',
      'forgot_password': 'पासवर्ड बिर्सनुभयो?',
      'sign_in': 'लगइन गर्नुहोस्',
      'sign_up': 'दर्ता गर्नुहोस्',
      'create_account': 'खाता सिर्जना गर्नुहोस्',
      'full_name': 'पूरा नाम',
      'phone_number': 'फोन नम्बर',
      'enter_password': 'आफ्नो पासवर्ड लेख्नुहोस्',
      'remember_me': 'मलाई सम्झनुहोस्',
      'logging_in': 'लगइन हुँदैछ...',
      'no_account': 'खाता छैन?',
      'register': 'दर्ता',
      'confirm_your_password': 'आफ्नो पासवर्ड पुष्टि गर्नुहोस्',
      'password_strength_hint':
          'कम्तीमा ८ अक्षर, ठूलो र सानो अक्षर तथा एउटा अंक प्रयोग गर्नुहोस्।',
      'creating_account': 'खाता सिर्जना हुँदैछ...',
      'already_have_account': 'पहिले नै खाता छ?',
      'continue': 'अगाडि बढ्नुहोस्',
      'unavailable': 'उपलब्ध छैन',
      'order_id': 'अर्डर आईडी:',
      'thank_you_order_success': 'धन्यवाद! तपाईंको अर्डर सफलतापूर्वक राखियो।',
      'change_profile_picture': 'प्रोफाइल तस्बिर परिवर्तन गर्नुहोस्',
      'take_photo': 'फोटो खिच्नुहोस्',
      'choose_gallery': 'ग्यालेरीबाट छान्नुहोस्',
      'remove_selected_photo': 'चयन गरिएको फोटो हटाउनुहोस्',
      'name': 'नाम',
      'enter_name': 'आफ्नो नाम लेख्नुहोस्',
      'enter_email': 'आफ्नो इमेल ठेगाना लेख्नुहोस्',
      'enter_phone': 'आफ्नो फोन नम्बर लेख्नुहोस्',
      'address': 'ठेगाना',
      'no_address_added': 'ठेगाना थपिएको छैन',
      'address_line_2': 'ठेगाना लाइन २',
      'street_address_hint': 'सडक ठेगाना वा घर नम्बर',
      'apartment_hint': 'अपार्टमेन्ट, तला वा चिनारी',
      'enter_city': 'आफ्नो सहर लेख्नुहोस्',
      'enter_state': 'आफ्नो प्रदेश लेख्नुहोस्',
      'enter_zip': 'हुलाक कोड लेख्नुहोस्',
      'enter_country': 'आफ्नो देश लेख्नुहोस्',
      'saving': 'सेभ हुँदैछ...',
      'save_changes': 'परिवर्तन सेभ गर्नुहोस्',
      'change_photo': 'फोटो परिवर्तन गर्नुहोस्',
      'confirm_order': 'आफ्नो अर्डर पुष्टि गर्नुहोस्',
      'payment_title': '@method भुक्तानी',
      'place_order': 'अर्डर राख्नुहोस्',
      'continue_to_gateway': '@gateway मा अगाडि बढ्नुहोस्',
      'continue_to_payment': 'भुक्तानीतर्फ अगाडि बढ्नुहोस्',
      'payable_amount': 'तिर्नुपर्ने रकम',
      'secure_checkout': 'सुरक्षित स्यान्डबक्स चेकआउट',
      'cod_pay_delivery': 'अर्डर डेलिभरी हुँदा भुक्तानी गर्नुहुनेछ।',
      'secure_checkout_description':
          'वालेट विवरण, पासवर्ड, पिन र ओटीपी आधिकारिक @method स्यान्डबक्स चेकआउटभित्र मात्र प्रविष्ट गरिनेछ।',
      'cod_instruction':
          'तपाईंको अर्डर डेलिभरीमा नगदमार्फत राखिनेछ। अर्डर आएपछि भुक्तानी गर्न सक्नुहुन्छ।',
      'khalti_instruction':
          'भुक्तानी पूरा गर्न तपाईंलाई सुरक्षित रूपमा Khalti Sandbox मा पठाइनेछ।',
      'esewa_instruction':
          'भुक्तानी पूरा गर्न तपाईंलाई सुरक्षित रूपमा eSewa Sandbox मा पठाइनेछ।',
      'order_details': 'अर्डर विवरण',
      'products': 'उत्पादनहरू',
      'shipping_fee': 'ढुवानी शुल्क',
      'view_order_tracking': 'अर्डर ट्र्याकिङ हेर्नुहोस्',
      'buy_again': 'फेरि किन्नुहोस्',
      'order_not_found': 'अर्डर फेला परेन',
      'unable_load_wishlist': 'इच्छासूची लोड गर्न सकिएन।',
      'something_went_wrong': 'केही समस्या भयो।',
      'item_removed_wishlist': 'वस्तु इच्छासूचीबाट हटाइयो',
      'failed_remove_item': 'वस्तु हटाउन सकिएन',
      'unable_load_categories':
          'श्रेणीहरू लोड गर्न सकिएन। फेरि प्रयास गर्नुहोस्।',
      'unable_load_products':
          'उत्पादनहरू लोड गर्न सकिएन। फेरि प्रयास गर्नुहोस्।',

      // ----------------------------------------------------------
      // CHANGE PASSWORD
      // ----------------------------------------------------------
      "update_your_password": "पासवर्ड अद्यावधिक गर्नुहोस्",
      "current_password": "हालको पासवर्ड",
      "enter_current_password": "हालको पासवर्ड प्रविष्ट गर्नुहोस्",
      "new_password": "नयाँ पासवर्ड",
      "enter_new_password": "नयाँ पासवर्ड प्रविष्ट गर्नुहोस्",
      "confirm_password": "पासवर्ड पुष्टि गर्नुहोस्",
      "confirm_new_password": "नयाँ पासवर्ड पुनः प्रविष्ट गर्नुहोस्",
      "password_requirement": "पासवर्ड कम्तीमा ८ अक्षरको हुनुपर्छ।",

      // ----------------------------------------------------------
      // PRIVACY POLICY
      // ----------------------------------------------------------
      'privacy_content': '''
गोपनीयता नीति

अन्तिम अद्यावधिक: जनवरी १, २०२६

हाम्रो अनुप्रयोगमा स्वागत छ। तपाईंको गोपनीयता हाम्रो लागि अत्यन्त महत्त्वपूर्ण छ। यो गोपनीयता नीतिले हाम्रो अनुप्रयोग प्रयोग गर्दा तपाईंको जानकारी कसरी सङ्कलन, प्रयोग, सुरक्षित तथा व्यवस्थापन गरिन्छ भन्ने बारे जानकारी प्रदान गर्दछ।

१. हामीले सङ्कलन गर्ने जानकारी

हामी निम्न जानकारी सङ्कलन गर्न सक्छौं:

• तपाईंको नाम
• इमेल ठेगाना
• फोन नम्बर
• प्रोफाइल सम्बन्धी जानकारी
• उपकरण सम्बन्धी जानकारी
• अनुप्रयोग प्रयोग सम्बन्धी तथ्याङ्क

२. जानकारीको प्रयोग

हामी तपाईंको जानकारी निम्न उद्देश्यका लागि प्रयोग गर्छौं:

• खाता सिर्जना तथा व्यवस्थापन
• सेवाको गुणस्तर सुधार
• ग्राहक सहायता प्रदान गर्न
• आवश्यक सूचना पठाउन
• अनुप्रयोगको सुरक्षा कायम राख्न
• कार्यसम्पादन विश्लेषण गर्न

३. जानकारीको सुरक्षा

हामी तपाईंको व्यक्तिगत जानकारीलाई अनधिकृत पहुँच, परिवर्तन, दुरुपयोग वा नष्ट हुनबाट जोगाउन उचित सुरक्षा उपायहरू अपनाउँछौं।

४. जानकारी साझेदारी

हामी तपाईंको व्यक्तिगत जानकारी बिक्री गर्दैनौं। आवश्यक परे मात्र जानकारी साझा गरिन्छ:

• कानुनी आवश्यकता अनुसार
• हाम्रो कानुनी अधिकारको संरक्षणका लागि
• विश्वसनीय सेवा प्रदायकसँग

५. कुकी तथा विश्लेषण

हाम्रो अनुप्रयोगले प्रयोगकर्ताको अनुभव सुधार गर्न र प्रयोगको विश्लेषण गर्न कुकी वा अन्य विश्लेषण उपकरण प्रयोग गर्न सक्छ।

६. तपाईंका अधिकार

तपाईंलाई निम्न अधिकारहरू प्राप्त छन्:

• आफ्नो जानकारी हेर्न
• गलत जानकारी सच्याउन
• आफ्नो खाता हटाउन
• आफ्ना डाटाको प्रतिलिपि माग्न
• दिएको सहमति फिर्ता लिन

७. बालबालिकाको गोपनीयता

यो अनुप्रयोग कानुनी उमेरभन्दा कम उमेरका बालबालिकाका लागि लक्षित गरिएको होइन।

८. तेस्रो पक्षका सेवाहरू

हाम्रो अनुप्रयोगमा तेस्रो पक्षका सेवाहरू वा लिंकहरू हुन सक्छन्। तिनीहरूको गोपनीयता नीतिका लागि हामी जिम्मेवार हुने छैनौं।

९. गोपनीयता नीतिमा परिवर्तन

आवश्यक परेमा यो गोपनीयता नीति समय-समयमा अद्यावधिक गर्न सकिन्छ।

१०. सम्पर्क

यदि यस गोपनीयता नीतिसम्बन्धी कुनै प्रश्न वा सुझाव छन् भने कृपया हाम्रो आधिकारिक सहायता माध्यममार्फत सम्पर्क गर्नुहोस्।

हाम्रो अनुप्रयोग प्रयोग गर्नुभएकोमा धन्यवाद।
''',

      // ----------------------------------------------------------
      // TERMS
      // ----------------------------------------------------------
      'terms_content': '''
१. अनुप्रयोग जिम्मेवारीपूर्वक प्रयोग गर्नुहोस्।

२. प्रयोगकर्ताको गोपनीयताको सम्मान गर्नुहोस्।

३. अनधिकृत पहुँच निषेध छ।

४. अनुप्रयोगको सामग्री परिवर्तन हुन सक्छ।

५. यो एप प्रयोग गर्दा तपाईं सबै नियमहरूमा सहमत हुनुहुन्छ।
''',
    },
  };
}
