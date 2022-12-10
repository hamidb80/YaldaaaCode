import std/[strutils, strformat]
import database, markdownv2, tg

const
  greetingD* = ss dedent """
    سلام به مسابقه *یلدا کد* انجمن علمی مهندسی کامپیوتر دانشگاه شاهد خوش اومدی!
    😍

    برای مسابقه آماده ای؟
    👩‍💻
  """

  youAreNotAdminMyDearD* = dedent """
    عزیزم شما ادمین نیستی
    😠
  """

  wereOutOfPuzzles* = dedent """
    متاسفانه ظرفیت پر شده - من به ادمین خبر میدم...
    
    لطفا نیم ساعت دیگه دوباره امتحان کن
    🕒
  """

  outputPuzzleAlertD* = dedent """
    ظرفیت تموم شده - لطفا شعر اضافه کن
  """

  sendMyInputsD* = strip """
    ورودی هامو بفرست
  """

  wannaAnswerD* = strip """
    میخوام جواب رو بدم
  """

  problemAccuredD* = dedent """
    مشکلی پیش آمد
    🚧
  """

  doubtSolvedProblemD* = dedent """ 
    واقعا فکر میکنی جواب درست رو پیدا کردی؟ 
    خب اگر راست میگی جوابو بفرست ببینم ...
    🤔
  """

  congratsD* = dedent """ 
    ایول بابا! خود خودشه!
    🎉
  """

  sorryTryAgainD* = dedent """ 
    نه درست نیست. دوباره تلاش کن
    🙃
  """

  youWonAlreadyD* = dedent """
    مسابقه همین یدونه سوال بود که جواب دادی! یلدا خوش بگذره!
    😘
  """

  poetFormatAlertD* = dedent """
    گوی شعر اشتباه است. توجه کنید که باید بین دو مصرع ` *** ` بیاید.
    😓
  """

  savedD* = dedent """
    ثبت شد
    ✅
  """

  youAttendedBeforeD* = dedent """
    شما قبلا در مسابقه شرکت کرده اید
    🤨
  """

  resetedD* = dedent """
    ریست شد
    👍
  """

  invalidInputD* = dedent """
    ورودی نامعتبر
    😦
  """

  adminCommandsD* = dedent fmt"""
    :دستورات
    /{$acStats}: آمار
    /{$acAddpoet}: اضافه کردن شعر
    /{$acReset}: ریست کردن با کاربر ورودی با چت آیدی
    /{$acPromote}: ترفیع به ادمین با چت آیدی

    مثال استفاده:
    /{$acStats}
    /{$acAddpoet} ملکا ذکر تو گویم *** که تو پاکی و خدایی
    /{$acReset} 101862091
    /{$acPromote} 101862091
  """

  emailContentD = dedent """
    متن ایمیل
  """

  logFileD = "log file"

let
  problemK* = toReplyKeyboard @[sendMyInputsD, wannaAnswerD]


func reprStats*(st: Stats): string =
  fmt"""
    شرکت کننده ها: {st.users}
    حل کرده: {st.answered}
    شعر های آزاد: {st.free}
    همه شعر ها: {st.total}
  """

func reprInputs*(p: Puzzle): StyledString =
  ss fmt """{bold emailContentD}: "{p.shuffled}"\n\n{bold logFileD}:\n{codeBlock p.logs}"""

func isValidPoet*(sentence: string): bool =
  "***" in sentence

func cleanFrom(s: string, excluded: set[char]): string =
  for ch in s:
    if ch notin excluded:
      result.add ch

func cleanPoet*(s: string): string =
  cleanFrom s, {' ', '*'}
