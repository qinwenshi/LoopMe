<%--
  Created by IntelliJ IDEA.
  User: gunther
  Date: 9/25/16
  Time: 10:32 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script>
    function displayBackgroundMap() {
        console.log("Lat:" + sessionStorage.getItem("lat"));
        console.log("Lng:" + sessionStorage.getItem("lng"));

        //Check to see if we have already loaded the user location map
        //If we haven't, find user and set sessionStorage variables
        if (sessionStorage.getItem("lat") == null && sessionStorage.getItem("lng") == null) {
            console.log("Position not stored.");

            //Find User
            if (navigator.geolocation) {
                var timeoutVal = 10 * 1000 * 1000;
                navigator.geolocation.getCurrentPosition(
                        displayUserLocationMap,
                        displayDefaultMap,
                        {enableHighAccuracy: true, timeout: timeoutVal, maximumAge: 0}
                );
            }
            else {
                alert("Geolocation is not supported by this browser");
            }
            //User doens't allow location
            function displayDefaultMap(error) {
                //Store position
                sessionStorage.setItem("lat", 38.897540);
                sessionStorage.setItem("lng", -77.036958);

                // Create a map object and specify the DOM element for display.
                var map = new google.maps.Map(document.getElementById('map'), {
                    center: {lat: 38.897540, lng: -77.036958},
                    scrollwheel: false,
                    zoom: 13
                });
            }

            //User allows location
            function displayUserLocationMap(position) {
                //Store position
                sessionStorage.setItem("lat", position.coords.latitude);
                sessionStorage.setItem("lng", position.coords.longitude);
                // Create a map object and specify the DOM element for display.
                var map = new google.maps.Map(document.getElementById('map'), {
                    center: {lat: position.coords.latitude, lng: position.coords.longitude},
                    scrollwheel: false,
                    zoom: 13
                });

                //Set input field
                if (sessionStorage.getItem("address") == null) {
                    var latlng = {lat: position.coords.latitude, lng: position.coords.longitude};
                    var geocoder = new google.maps.Geocoder();
                    geocoder.geocode({'location': latlng}, function (results, status) {
                        if (status === 'OK') {
                            if (results[1]) {
                                sessionStorage.setItem("address", results[1].formatted_address.toString());
                                document.getElementById("inputLocation").value = results[1].formatted_address.toString();
                            } else {
                                alert("No results found");
                            }
                        } else {
                            alert("Gedocoder failed due to: " + status);
                        }
                    });
                } else {
                    document.getElementById("inputLocation").value = sessionStorage.getItem("address");
                }
            }
        }
        //Position previous stored
        else {
            console.log("Using stored coordinates");
            var lat = sessionStorage.getItem("lat");
            var lng = sessionStorage.getItem("lng");
            var map = new google.maps.Map(document.getElementById('map'), {
                center: {lat: parseFloat(lat), lng: parseFloat(lng)},
                scrollwheel: false,
                zoom: 13
            });

            if (sessionStorage.getItem("address")) {
                console.log("Using stored address");
                document.getElementById("inputLocation").value = sessionStorage.getItem("address");
            }
        }
    }
</script>