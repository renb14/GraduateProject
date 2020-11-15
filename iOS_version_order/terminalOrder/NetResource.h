//
//  NetResource.h
//  terminalOrder
//
//  Created by ren will on 20/03/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#ifndef NetResource_h
#define NetResource_h


#define AWSS3URL @"https://s3-us-west-2.amazonaws.com/elasticbeanstalk-us-west-2-528233739287/"
#define AWSURLBASE @"https://m3g78050xe.execute-api.us-west-2.amazonaws.com/prod/"
#define GETUSERINFOBYID @"userAction/"
#define POSTUSERINFO    @"userAction"
#define POSTREGIONBYMAP @"searchFandianByMap"
#define GETMENUDATABYRESTID @"searchMenuByFandian/"
#define POSTRESTAURANTBYLOCATION    @"searchFandianByCity"
#define POSTREGIONBYMAPRESOURCE @"com.awsserverless.apigatelambda.requestaction.SearchRestaurantByMapRequest"
#define POSTRESTAURANTBYLOCATIONRESOURCE @"com.awsserverless.apigatelambda.requestaction.SearchRestaurantByCityRequest"

//For database
#define DATABASEDISHTABLE   @"dishtable"

//For Notification
#define GETNOTIFICATIONADDSELECTEDDISH  @"notificationaddselecteddish"
#define GETNOTIFICATIONDELETESELECTEDDISH   @"notificationdeleteselecteddish"
#define GETNOTIFICATIONCOMMENTONDISH    @"notificationcommentondish"

//For Data struct
//nsdictionary on comments
#define COMMENTUSERID   @"commentuserid"
#define COMMENTUSERNAME @"commentusername"
#define COMMENTTIME     @"commenttime"
#define COMMENTCONTENT  @"commentcontent"   //nsstring
#define COMMENTLIKE     @"commentlike"      //INGE
#define COMMENTONDISHID @"commentondishid"
#define COMMENTONRESTID @"commentonrestid"
//nsdictionary on orderhistory
#define HISTORYRESTID   @"historyrestid"
#define HISTORYDISHIDLIST   @"historydishidlist"
#define HISTORYORDERTIME    @"historydishtime"
#define HISTORYORDERRESTNAME    @"historyorderrestname"
#define HISTORYATTENDNUMBER @"historyorderateendnum"
#define HISTORYORDERNAME    @"historyordername"
#define HISTORYORDERPRICE   @"historyorderprice"
#define HISTORYORDERCONTACT @"historyordercontact"

#endif /* NetResource_h */
