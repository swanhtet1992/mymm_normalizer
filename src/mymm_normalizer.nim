import json, nre
type
  json_rule = ref object
    ofrom:string
    to:string

proc normalize*(input_string:string): string=
  var output = input_string
  let json_rules = """[
    {
      "ofrom":"(*UTF8)([\u102B-\u1035])([\u103B-\u103E])", 
      "to":"$2$1"
    },
    {
      "ofrom":"(*UTF8)\u1036\u102F", 
      "to":"ုံ"
    },
    {
      "ofrom":"(*UTF8)([\u1000-\u1020])(\u103D)(\u1031)(\u103E)",
      "to":"$1$2$4$3"
    },
    {
      "ofrom":"(*UTF8)(\u103A)(\u1037)",
      "to":"$2$1"
    },
    {
      "ofrom":"(*UTF8)(\u1036)(\u102F)",
      "to":"$2$1"
    },
    {
      "ofrom":"(*UTF8)\u103E\u103B", 
      "to":"ျှ"
    },
    {
      "ofrom":"(*UTF8)\u1037\u102C", 
      "to":"ာ့"
    },
    {
      "ofrom":"(*UTF8)(\u102B)+", 
      "to":"ါ"
    },
    {
      "ofrom":"(*UTF8)(\u102C)+", 
      "to":"ာ"
    },
    {
      "ofrom":"(*UTF8)(\u102D)+",
      "to":"ိ"
    },
    {
      "ofrom":"(*UTF8)(\u102E)+", 
      "to":"ီ"
    },
    {
      "ofrom":"(*UTF8)(\u102F)+",
      "to": "ု"
    },
    {
      "ofrom":"(*UTF8)(\u1030)+",
      "to": "ူ"
    },
    {
      "ofrom":"(*UTF8)(\u1031)+",
      "to": "ေ"
    },
    {
      "ofrom":"(*UTF8)(\u1032)+",
      "to": "ဲ"
    },
    {
      "ofrom":"(*UTF8)(\u1033)+",
      "to": "ဳ"
    },
    {
      "ofrom":"(*UTF8)(\u1034)+",
      "to": "ဴ"
    },
    {
      "ofrom":"(*UTF8)(\u1035)+",
      "to": "ဵ"
    },
    {
      "ofrom":"(*UTF8)(\u1036)+",
      "to": "ံ"
    },
    {
      "ofrom":"(*UTF8)(\u1037)+",
      "to": "့"
    },
    {
      "ofrom":"(*UTF8)(\u1038)+",
      "to": "း"
    },
    {
      "ofrom":"(*UTF8)(\u1039)+",
      "to": "္"
    },
    {
      "ofrom":"(*UTF8)(\u103A)+",
      "to": "်"
    },
    {
      "ofrom":"(*UTF8)(\u103B)+",
      "to": "ျ"
    },
    {
      "ofrom":"(*UTF8)(\u103C)+",
      "to": "ြ"
    },
    {
      "ofrom":"(*UTF8)(\u103D)+",
      "to": "ွ"
    },
    {
      "ofrom":"(*UTF8)(\u103E)+",
      "to": "ှ"
    },
    {
      "ofrom":"(*UTF8)(\u103F)+",
      "to": "ဿ"
    },
    {
      "ofrom":"(*UTF8)(\u102F\u1036)+",
      "to": "ုံ"
    },
    {
      "ofrom":"(*UTF8)(\u102D\u102F)+",
      "to": "ို"
    },
    {
      "ofrom":"(*UTF8)([\u1000-\u1021])(\u102F)(\u102D)",
      "to": "$1$3$2"
    },
    {
      "ofrom":"(*UTF8)([\u1000-\u1021])(\u1030)(\u102D)",
      "to": "$1$3ု"
    },
    {
      "ofrom":"(*UTF8)\u102F\u102E",
      "to": "ီု"
    },
    {
      "ofrom":"(*UTF8)([\u1000-\u1020])(\u103E)(\u1031)(\u103B)",
      "to": "$1$4$2$3"
    },
    {
      "ofrom":"(*UTF8)\u1040\u102D}(?!\u0020}?/)",
      "to": "ဝိ"
    },
    {
      "ofrom":"(*UTF8)([^\u1040-\u1049])\u1040}([^\u1040-\u1049\u0020]|[\u104a\u104b])",
      "to": "$1ဝ$2"
    },
    {
      "ofrom":"(*UTF8)(\u1040)([\u102B-\u1032])",
      "to": "ဝ$2"
    },
    {
      "ofrom":"(*UTF8)(\u1040)(\u1036)",
      "to": "ဝ$2"
    },
    {
      "ofrom":"(*UTF8)(\u1040)(\u103A)",
      "to": "ဝ$2"
    },
    {
      "ofrom":"(*UTF8)(\u1040)(\u103E)",
      "to": "ဝ$2"
    },
    {
      "ofrom":"(*UTF8)(\u1047)( ? = [\u1000} - \u101C\u101E} - \u102A\u102C\u102E} - \u103F\u104C} - \u109F\u0020])",
      "to": "ရ"
    },
    {
      "ofrom":"(*UTF8)\u1047\u1031",
      "to": "ရေ"
    },
    {
      "ofrom":"(*UTF8)([\u1000-\u1021])(\u1036)(\u103D)(\u1037)",
      "to": "$1$3$2$4"
    },
    {
      "ofrom":"(*UTF8)([\u1000-\u1021])(\u102D)(\u1039)([\u1000-\u1021])",
      "to":"$1$3$4$2"
    },
    {
      "ofrom":"(*UTF8)([\u1000-\u1021])(\u1036)(\u103E)",
      "to": "$1$3$2"
    },
    {
      "ofrom":"(*UTF8)\u1037\u102F",
      "to": "ု့"
    },
    {
      "ofrom":"(*UTF8)\u1036\u103D",
      "to": "ွံ"
    },
    {
      "ofrom":"(*UTF8)(\u1004)(\u1031)(\u103A)(\u1039)([\u1000-\u1021])",
      "to":"$1$3$4$5$2"
    },
    {
      "ofrom":"(*UTF8)(\u102D)(\u103A)+", 
      "to":"$1"
    },  
    {
      "ofrom":"(*UTF8)\u1025\u103A",
      "to": "ဉ်"
    },
    {
      "ofrom":"(*UTF8)\u200B",
      "to": ""
    },
    {
      "ofrom":"(*UTF8)\u200C",
      "to": ""
    },
    {
      "ofrom":"(*UTF8)\u202C",
      "to": ""
    },
    {
      "ofrom":"(*UTF8)\u00A0",
      "to": ""
    },  
    {
      "ofrom":"(*UTF8)([\u1000-\u1021])(\u1031)(\u103D)",
      "to": "$1$3$2"
    },
    {
      "ofrom":"(*UTF8)([\u1000-\u1021])(\u1031)(\u103E)(\u103B)",
      "to": "$1$3$4$2"
    }
  ]"""
  
  let jrules = parseJson(json_rules)
  let rules:seq[json_rule] = to(jrules, seq[json_rule])
  
  for rule in rules:
    output = output.replace(re(rule.ofrom), rule.to)

  return output