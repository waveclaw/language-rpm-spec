# RPM Specfile support in atom

[![Build Status](https://travis-ci.org/waveclaw/language-rpm-spec.svg?branch=master)](https://travis-ci.org/waveclaw/language-rpm-spec)

Add syntax highlighting and snippets to package.spec files in Atom.

## Example

 This particular highlighting scheme is based on the KDE Project coloring and
spec.nanorc by Asterios Dramis.

![A screenshot of your package](https://raw.githubusercontent.com/waveclaw/language-rpm-spec/master/atom-language-rpm-spec.png)

## Background

RPM Package Manager files are the packaging format of many popular Linux
distributions such as RedHat and CentOS, openSuSE and the Fedora Project. RPMs
use a specfile to describe how to take upstream sources and deploy them onto a
Linux operating system.

A specfile ends in .spec and is usually named for the project's source code that
is to be deployed.  The process of making an RPM from the various parts, known
as building, is driven the the instructions in the specfile.

High quality specfiles are a key part of providing repeatable and consistent
experiences delivering programs, fonts, graphics, utilities and even entire
operating system environments to the end user or system administrator.  Syntax
highlighting editors are a method of helping improve the quality of edited files
through catching simple but well-hidden typos, syntax errors and misplaced
keywords.

## Contributing

Contributions are welcome.  Please fork and make any pull requests needed for
corrections, new snippets or grammar tweaks.
