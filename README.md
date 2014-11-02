sycamoreAPI
===========

This is a swift API to the sycamore education interface

To use it, perform the following steps:  
* Go to http://http://dev.sycamoreeducation.com/developer/ and sign up as a developer
* Import the following files into your project:
 * SycamoreAPI.swift
 * Credentials.swift
 * SycamoreConstants.swift
* Update Credentials.swift appropriately
* Add URL scheme to the target info
* Update the app delegate to accept OAUTH2 tokens that come in from a successful sycamore login
