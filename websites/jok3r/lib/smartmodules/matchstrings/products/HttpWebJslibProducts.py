#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from lib.smartmodules.matchstrings.MatchStrings import products_match


WIG_REGEXP = '{}\s*[VERSION]\s*JavaScript' 
WIG_REGEXP2 = '- Found JavaScript: {}(\s*[VERSION])?'


products_match['http']['web-jslib'] = {
    'Angular': {
        'wappalyzer': 'Angular',
    },
    'AngularJS': {
        'wappalyzer': 'AngularJS',
        'wig': [
            WIG_REGEXP.format('AngularJS'),
            WIG_REGEXP2.format('AngularJS'),
        ],
        'angularjs-csti-scanner': '\[INFO\] Found AngularJS version [VERSION]',
    },
    'Backbone.js': {
        'wappalyzer': 'Backbone.js',
    },
    'Dojo': {
        'wappalyzer': 'Dojo',
        'wig': [
            WIG_REGEXP.format('Dojo'),
            WIG_REGEXP2.format('Dojo'),
        ],
    },
    'ef.js': {
        'wappalyzer': 'ef.js',
    },
    'FancyBox': {
        'wappalyzer': 'FancyBox',
    },
    'Handlebars': {
        'wappalyzer': 'Handlebars',
    },
    'Jquery': {
        'wappalyzer': 'jQuery',
        'wig': [
            WIG_REGEXP.format('jQuery'),
            WIG_REGEXP2.format('jQuery'),
        ],
    },
    # 'Jquery UI': {
    #     'wappalyzer': 'jQuery UI',
    # },
    'Lightbox': {
        'wappalyzer': 'Lightbox',
    },
    'Modernizr': {
        'wappalyzer': 'Modernizr',
        'wig': [
            WIG_REGEXP.format('Modernizr'),
            WIG_REGEXP2.format('Modernizr'),
        ],
    },
    'Moment.js': {
        'wappalyzer': 'Moment.js'
    },
    'MooTools': {
        'wappalyzer': 'MooTools',
        'wig': [
            WIG_REGEXP.format('MooTools'),
            WIG_REGEXP2.format('MooTools'),
        ],
    },
    'Mustache.js': {
        'wappalyzer': 'Mustache',
    },
    'Prototype Javascript Framework': {
        'wappalyzer': 'Prototype',
        'wig': [
            WIG_REGEXP.format('Prototype'),
            WIG_REGEXP2.format('Prototype'),
        ],
    },
    'React': {
        'wappalyzer': 'React',
    },
    'RequireJS': {
        'wappalyzer': 'RequireJS',
    },
    'TweenMax': {
        'wappalyzer': 'TweenMax',
    },
    'Underscore.js': {
        'wappalyzer': 'Underscore.js',
    },

}