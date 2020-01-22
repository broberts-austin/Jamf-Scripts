ReadMe for MakeMeAnAdminSelfService

It is recommended to push this script as a policy to self service to run only once per day.

The main part of the code was taken from a Jamf script called MakeMeAnAdmin.  
We edited the script to add the use of $4 as the amount of time.  
So you can put how much time (in minutes) into $4 and that will show long the user would get.  
We also added code to display the $4 back to the user, so they will know the exact amount of time.  
We did this because some users might need a different amount of time, depending on the use case.  
We created multiple policies with different times and tied those to smart computer groups.
We manually add the user to that group and they see the correct script in Self Service. 

Still looking for a way to let the user request the amount of time instead.  I think this would be easier than any manual processing.
