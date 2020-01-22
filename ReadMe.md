{\rtf1\ansi\ansicpg1252\cocoartf2511
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;\red255\green255\blue255;\red0\green0\blue0;
\red27\green31\blue35;}
{\*\expandedcolortbl;;\cssrgb\c0\c1\c1;\cssrgb\c100000\c100000\c100000\c0;\cssrgb\c0\c1\c1;
\cssrgb\c14236\c16210\c18100;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs28 \cf2 \cb3 ReadMe for MakeMeAnAdminSelfService\
\
\pard\pardeftab720\sl360\sa320\partightenfactor0
\cf4 \expnd0\expndtw0\kerning0
It is recommended to push this script as a policy to self service to run only once per day.\cf2 \kerning1\expnd0\expndtw0 \
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0
\cf2 The main part of the code was taken from a Jamf script called MakeMeAnAdmin.  \
We edited the script to add the use of $4 as the amount of time.  \
So you can put how much time (in minutes) into $4 and that\'92s how long the user would get.  \
We also added code to display the $4 back to the user, so they will know the exact amount of time.  \
We did this because some users might need additional time.  \
We created multiple policies with different times and tied those to smart computer groups.\
We manually add the user to that group and they see the correct script. \
\
Still looking for a way to let the user request the amount of time instead.  I think this would be easier than any manual processing.\
\
\
\
}