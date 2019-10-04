# R-Filters
iOS images filtration app with static cool filters and some animations.  

Part 1 Implement Filter and Compare functions

1. When a user taps a filter button, the image view will be updated with the filtered image.

· Useing the RGBAImage class to get access to the pixels contained in a UIImage object and apply the filter.

2. When a user taps the compare button, the image view show the original image. When they tap the button again, show the filtered image.

Part 2 Refine the UI

1. the compare button is Disable when a filter hasn’t been selected.

· If the user hasn’t selected a filter yet, then the image hasn’t changed, and the compare button isn’t useful. Disable the button when its function is not needed.

2. Makeing  it easier to compare the original and filtered images.

· When the user touches the image, toggle between the filtered, and original images temporarily.

· When the user lifts their finger,it toggle back.

3. Make it more explicit that the user is looking at the original image.

· a small overlay view on top of the image view with the text “Original”.

4. Cross-fade images when a user selects a new filter or uses the compare function.

· A smoother transition between images gives the app a more refined feel.

Part 3 save or share image

Using ImagePickerView and DataActionSheet




