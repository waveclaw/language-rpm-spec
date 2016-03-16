#
# Copyright (c) 2015 JD Powell <waveclaw@waveclaw.net>
#
# All modifications and additions to the file contributed by third parties
# remain the property of their copyright owners, unless otherwise agreed
# upon. The license for this file, and modifications and additions to the
# file, is the same license as for the pristine package itself (unless the
# license for the pristine package is not an Open Source License, in which
# case the license is the MIT License). An "Open Source License" is a
# license that conforms to the Open Source Definition (Version 1.9)
# published by the Open Source Initiative.
#
# Please submit bugfixes or comments via
# https://github.com/waveclaw/language-rpm-spec/issues
#
ed = require 'atom'
fs = require 'fs'
path = require 'path'

describe 'Changelog grammar', ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage('language-rpm-spec')

    runs ->
      grammar = atom.grammars.grammarForScopeName('source.changelogs.rpm-spec')

  it 'parses the grammar', ->
    expect(grammar).toBeDefined()
    expect(grammar.scopeName).toBe 'source.changelogs.rpm-spec'

  it 'tokenizes type I changelog entries', ->
    lines = grammar.tokenizeLines '''
* Thu Aug 13 21:31:52 UTC 2015 - jane@example.com
- I added this extra content
'''
    expect(lines[0][1]).toEqual value: 'Thu Aug 13 21:31:52 UTC 2015', scopes:
      ['source.changelogs.rpm-spec', 'constant.changelogs']
    expect(lines[0][3]).toEqual value: 'jane@example.com', scopes:
      ['source.changelogs.rpm-spec','variable.other.changelogs']
    expect(lines[1][1]).toEqual value: 'I added this extra content', scopes:
      ['source.changelogs.rpm-spec','comment.changelogs']

  it 'tokenizes type II changelog entries', ->
    lines = grammar.tokenizeLines '''
* Sun Nov 09 2014 John Doe <john.doe@example.com> 0.40.15-2
- I added this extra content
'''
    expect(lines[0][1]).toEqual value: 'Sun Nov 09 2014', scopes:
      ['source.changelogs.rpm-spec', 'constant.changelogs']
    expect(lines[0][3]).toEqual value: 'John Doe', scopes:
      ['source.changelogs.rpm-spec','entity.name.changelogs']
    expect(lines[0][5]).toEqual value: '<john.doe@example.com>', scopes:
      ['source.changelogs.rpm-spec','variable.other.changelogs']
    expect(lines[0][7]).toEqual value: '0.40.15-2', scopes:
      ['source.changelogs.rpm-spec','constant.numeric.changelogs']
    expect(lines[1][1]).toEqual value: 'I added this extra content', scopes:
      ['source.changelogs.rpm-spec','comment.changelogs']

  it 'tokenizes RedHat type changelog entries', ->
    lines = grammar.tokenizeLines '''
* Mon May 20 2013 Jane Doe <jdoe@redhat.com> - 3.0.0-26.el3_1.1
- foo bar
'''
    expect(lines[0][1]).toEqual value: 'Mon May 20 2013', scopes:
      ['source.changelogs.rpm-spec', 'constant.changelogs']
    expect(lines[0][3]).toEqual value: 'Jane Doe', scopes:
      ['source.changelogs.rpm-spec','entity.name.changelogs']
    expect(lines[0][5]).toEqual value: '<jdoe@redhat.com>', scopes:
      ['source.changelogs.rpm-spec','variable.other.changelogs']
    expect(lines[0][7]).toEqual value: '3.0.0-26.el3_1.1', scopes:
      ['source.changelogs.rpm-spec','constant.numeric.changelogs']
    expect(lines[1][1]).toEqual value: 'foo bar', scopes:
      ['source.changelogs.rpm-spec','comment.changelogs']

  it 'tokenizes old SuSE changelog entries', ->
    lines = grammar.tokenizeLines '''
* Sat Jul  3 2010 jane@suse.de
- I added this extra content
'''
    expect(lines[0][1]).toEqual value: 'Sat Jul  3 2010', scopes:
      ['source.changelogs.rpm-spec', 'constant.changelogs']
    expect(lines[0][3]).toEqual value: 'jane@suse.de', scopes:
      ['source.changelogs.rpm-spec','variable.other.changelogs']
    expect(lines[1][1]).toEqual value: 'I added this extra content', scopes:
      ['source.changelogs.rpm-spec','comment.changelogs']
