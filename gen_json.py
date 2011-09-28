#!/usr/bin/env python

import json, csv, sys, os

talks = []
speakers = []
speaker_dict = {}

def generate_speakers():
  reader = csv.reader(open("data/Speakers-Speakers.csv"))
  uid = 0
  for row in reader:
    uid += 1
    if uid == 1:
      continue
    if not row[0]: 
      continue
    print row
    name = row[1]
    full_name = row[0]
    if os.path.exists("data/images/%s.jpg" % name):
      pic = "http://community.nuxeo.com/static/nuxeo-world/2011/images/%s.jpg" % name
    else:
      pic = ""
    entity = {
      'picture': pic,
      'name': name,
      'full_name': full_name.strip(),
      'company': row[2],
      'uid': uid,
      'bio': row[3].strip() or "To be completed later.",
    }
    speakers.append({'entity': entity})
    speaker_dict[name] = full_name
  
  json.dump({'entities': speakers}, open("data/speakers.json", "wc"))

def generate_talks():
  reader = csv.reader(open("data/Talks-Talks.csv"))
  uid = 0
  for row in reader:
    entity = {}
    uid += 1
    if uid == 1:
      continue
    if not row[0]: 
      continue
    print row
    day = row[3][4:6]
    speakers = row[0].split(", ")
    speakers = [ speaker_dict[speaker] for speaker in speakers ]

    entity = {
      'title': row[1].strip(),
      'instructors': ", ".join(speakers),
      'room': row[2].strip() + " room",
      'time': "%s October %s - %s" % (day, row[4], row[5]),
      'nid': uid,
      'body': row[6].strip() or "To be completed later.",
    }
    print entity
    talks.append({'entity': entity})

  json.dump({'entities': talks}, open("data/sessions.json", "wc"))

generate_speakers()
generate_talks()
sys.exit()  
