sycamoreAPI
===========

This is a swift API to the sycamore education interface

To use it, perform the following steps:  
* Add URL scheme to the target info
* Go to http://http://dev.sycamoreeducation.com/developer/ and sign up as a developer
* Create a new application on the developer portal and add URL scheme to callback URI.  Use client ID and client secret in the next step
* Import the following files into your project:
 * SycamoreAPI.swift
 * Credentials.swift
 * SycamoreConstants.swift
* Update Credentials.swift appropriately
* Update the app delegate to accept OAUTH2 tokens that come in from a successful sycamore login
