<%@ Page Language="C#" AutoEventWireup="true" Inherits="FMCSS.FileData" CodeBehind="Files.aspx.cs" Async="true" ValidateRequest="false" %>

<!DOCTYPE html>
<html ng-app="fileApp">
<head>
    <title>Files</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/bootstrap.min.css"  />
    <link rel="stylesheet" href="css/FilesPage/files.css"  />
    <link rel="stylesheet" media="(min-width:670px) and (max-width: 1024px)" href="css/FilesPage/files-medium.min.css">
    <link rel="stylesheet" media="(max-width:669px)" href="css/FilesPage/files-small.min.css">
</head>
<body ng-cloak>
  <!--  <nav id="navigation">
        <div id="smallnavbar">
            <ul class="links">
                <li>Discover Thomson Reuters</li>
                <li>
                    <ul class="sublinks">
                        <li><a href="http://thomsonreuters.com/en/contact-us.html">contact</a></li>
                        <li><a href="http://thomsonreuters.com/en/support-training.html">support</a></li>
                    </ul>
                </li>
            </ul>
        </div>
        <div id="bignavbar">
            <ul class="links">
                <!--<li><img id="logo" src="content/bkLogo.svg" /></li>
                <li>fmc service system</li>
                <li class="sublinks slide">
                    <div><span class="switch">Log table</span></div>
                </li>
            </ul>
            <div class="hamburger">
                <svg xmlns="http://www.w3.org/2000/svg">
                    <path d="M 0 2 h 20 M 0 8 h 20 M 0 14 h 20" stroke="black" stroke-width="1" />
                </svg>
            </div>
        </div>
    </nav>
    <div id="verticalmenu">
        <div class="menu">
            <h3>Files</h3>
            <p class="switchToUploaded">Uploaded</p>
            <p class="switchToConverted">Converted</p>
        </div>
        <div class="info">
            <p>Files : <span>100</span></p>
        </div>
    </div>
    <div class="flipper">
        <section class="Container front" ng-controller="UploadedFileController">
            <div class="header">
                <h3>Files uploaded to request</h3>
                <div class="flip">Switch</div>
            </div>
            <div class="css">
                <label for="uploadedQuery">search</label>
                <input id="uploadedQuery" type="text" ng-model="uploadedQuery" />
                <div class="svgbtn">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64">
                        <path d="M0 64 L64 64 L64 38 L54 38 L54 56 L10 56 L10 38 L0 38 M38 36 L48 36 L32 48 L16 36 L26 36 L26 16 L38 16" />
                    </svg>
                </div>
            </div>
            <div class="table_wrapper tUploaded">
                <div class="theader">
                    <table>
                        <tr>
                            <td><span>#</span></td>
                            <td ng-click="sort('Name')">
                                <span>File name</span>
                                <span class="glyphicon {{ alphabetArrow }}" aria-hidden="true"></span>
                            </td>
                            <td ng-click="sort('Size')">
                                <span>Size (kB)</span>
                            </td>
                            <td ng-click="sort('CreationDate')">Date</td>
                        </tr>
                    </table>
                </div>
                <div class="tbody">
                    <table ng-hide="emptyTable">
                        <tr ng-repeat="file in files | filter : uploadedQuery | orderBy:order">
                            <td>{{ $index + 1 }}</td>
                            <td>{{ file.Name }}</td>
                            <td>{{ file.Size / 1024 | number : 2 }}</td>
                            <td>{{ file.CreateDate }}</td>
                        </tr>
                    </table>
                </div>
            </div>
        </section>
        <section class="Container back active" ng-controller="ConvertedFileController">
            <div class="header">
                <h3>Converted Files to download </h3>
                <div class="flip">Switch</div>
            </div>
            <div class="css">
                <label for="convertedQuery">search</label>
                <input id="convertedQuery" type="text" ng-model="convertedQuery" ng-disabled="emptyTable" />
                <div class="svgbtn">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64">
                        <path d="M0 64 L64 64 L64 38 L54 38 L54 56 L10 56 L10 38 L0 38 M38 28 L48 28 L32 16 L14 28 L26 28 L26 48 L38 48" />
                    </svg>
                </div>
            </div>
            <div class="table_wrapper tConverted">
                <div class="theader">
                    <table>
                        <tr>
                            <td><span>#</span></td>
                            <td><span class="glyphicon glyphicon-flag"></span></td>
                            <td><span class="glyphicon glyphicon-plus"></span></td>
                            <td ng-click="sort('Name')">
                                <span>File Name</span>
                                <span class="glyphicon {{ alphabetArrow }}" aria-hidden="true"></span>
                            </td>
                            <td ng-click="sort('Size')">
                                <span>Size (kB) </span>
                                <span class="glyphicon {{ arrow }}" aria-hidden="true"></span>
                            </td>
                            <td ng-click="sort('CreationDate')">
                                <span>Date</span>
                                <span class="glyphicon {{ arrow }}" aria-hidden="true"></span>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="tbody">
                    <table ng-hide="emptyTable">
                        <tr ng-repeat="file in files | filter : convertedQuery ">
                            <td>{{ $index + 1 }}</td>
                            <td>
                                <span ng-model="file.Checkbox" ng-hide="!file.International" class="glyphicon glyphicon-arrow-right"></span>
                                <input type="checkbox" class="IsInternational" ng-model="file.Checkbox" ng-hide="file.International" ng-change="change($index)">
                            </td>
                            <td>
                                <a ng-href="{{ file.Link }}">
                                    <span class="glyphicon {{ icon }}" aria-hidden="true"></span>
                                </a>
                            </td>
                            <td>
                                <span data-toggle="popover" data-placement="top"
                                      style="color: {{file.International ? '#cc3300' : ''}}"
                                      data-content="{{file.International ? internationalInfo : ''}}">{{ file.Name }}</span>
                            </td>
                            <td>{{ file.Size / 1024 | number : 2 }}</td>
                            <td>{{ file.CreateDate }}</td>
                        </tr>
                    </table>
                </div>
            </div>
        </section>
    </div>
    <div id="footer">
        <div class="buttons">
            <div class="left">
                <div class="fileUpload" data-toggle="popover" id="UploadButtonActive" data-placement="top" data-content="Upload new files to project">
                    <input id="uploadFile" class="inputfile" multiple type="file" data-ng-click="AddToUploadedFilesTable()" />
                    <label for="uploadFile"><span class="glyphicon glyphicon-cloud-upload"></span>Upload additional files</label>
                </div>
              <span class="glyphicon glyphicon-cloud-upload"></span>
                glyphicon glyphicon-cloud-download
                <div data-toggle="popover" id="UploadButtonNOTActive" runat="server"
                     data-placement="top" data-content="Uploading files is disabled to requests that are Completed or Cancelled"
                     style="background-color: #047aa7">
                    <span>Upload additional files</span>
                </div>
            </div>
            <div class="right">
                <div id="RightTablePanel">
                        <button id="selected" class="selectedfile inpfile" ng-disabled="emptyTable" 
                                 data-toggle="popover" data-placement="top" ng-click="clearCheckbox" Text="Download Selected"
                                 data-content="Download Selected files as zip, except files with international names"  />
                        <label for="selectedfile"><span class="glyphicon glyphicon-cloud-download"></span>Download selected files</label>

                        <button  id="zip" class="zipfile inpfile" ng-disabled="emptyTable"
                                    data-toggle="popover" data-placement="top" Text="Download All"
                                    data-content="Download All files as zip, except files with international names" />
                        <label for="zipfile"><span class="glyphicon glyphicon-cloud-download"></span>Download all files</label>
                    </div>
            </div>
        </div>
    </div>

    <script src="/Scripts/jquery-3.0.0.min.js"></script>
    <script src="/clientFacing/css/bootstrap/js/bootstrap.min.js"></script>
    <script src="/Scripts/Angular/angular.min.js"></script>
    <script src="/JS/Files/App.js"></script>
    <script src="/JS/Files/files.js?1506"></script>-->
    
</body>
</html>