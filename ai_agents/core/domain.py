# Web Automation Framework Empowered by Local AI Agents
# Copyright (C) 2026  A. Furkan KIZILTEPE <furkan.kiziltepe@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
import json
from pathlib import Path

DOCUMENT = """
RFQ and quotes (Sourcing in the menu) sends requests for quotation from the workspace and follows them to the order. An RFQ has one or more lines (parts); each supplier is asked on the lines ticked for it, so one request can go all to one supplier, or its component repair to repair shops and its consumables to distributors.

New RFQ: the lines (part number, description, quantity and unit, type: outright, exchange, repair, loan; conditions accepted; the day it is needed), typed, or pasted from Excel or a Wings list; the priority and the time to answer by (4 h for AOG, 1 d AOG risk, 2 d critical, 3 d routine unless set; a manager changes these defaults on the Settings page); optionally a title and the Wings REQ number. Then the suppliers, each with its addresses and the lines it is asked on (all lines by default). Suggest suppliers from history lists the suppliers that supplied the parts (Wings orders) or quoted them (earlier RFQs), with the lines they fit and their known addresses. Any address can be typed, and a supplier not in the workspace yet is added as pending under the name typed. Addresses entered are kept as supplier contacts. Each supplier shows its standing on the line types it is asked on: suggestions list disqualified suppliers last, without Add, and the workspace refuses to ask them; a suspended supplier is asked only with a reason, kept on its invite and shown under Suppliers asked. /rfqs/new?part=… or ?parts=A,B,C starts with those lines and their suppliers filled in. 1a. What the mail asks: the delivery terms we ask for (an Incoterms 2020 code such as EXW or FCA with its named place, e.g. FCA Istanbul Airport; empty asks each supplier to state its own), and the questions, prefilled from the line types on the RFQ and ticked off or on by the buyer. Every line: release form (EASA Form 1, FAA 8130-3 for new parts, 8130-3 with EASA dual release for used parts, or a CoC) and price with currency; outright purchase, exchange and loan also condition and lead time; a purchase the quantity the price is for; an exchange the core charge, exchange basis (standard with O&A, or flat rate), core due days and what they count from, grace days and late core fee, the day it becomes an outright sale, the O&A cap, when our core is BER, the supplier's claim window and its core acceptance conditions; a repair the work basis and pricing, evaluation or bench-check fee (and whether it is charged when we decline), no-fault-found fee, BER limit and return-as-is fee, days to quote and days to repair after approval; a loan its minimum days and return terms. Once for the quote: delivery terms, charges not included (freight, packing, certification, AOG surcharge, bank charges, or none), how long the price is held firm, warranty. Short AOG mail keeps price, condition, release form, lead time (days to repair for a repair) and delivery terms; it is on by default for an AOG (a manager can switch that default off on the Settings page). The questions as the mail writes them shows the numbered list. A line of a new type added later brings that type's questions. Which release forms SHGM accepts is for your Quality team to confirm.
Sending: one mail per supplier from the workspace mailbox, in English, listing its lines under their numbers, then the numbered questions (Please answer for each line: under the line for one line or one type, grouped by line type when the request mixes types, numbered on through the groups, then those for the whole quote), with [RFQ-26-0001] in the subject, our own Message-ID, and the mailbox as reply address. Lines added later, or asked of a supplier later, go in its conversation with the next Send, with their questions. Files (a Word request, a drawing, a price list: PDF, Word, Excel, text or picture, 5 files of 2 MB together) go with the mail from the send area, or with a message to one supplier; each file stays on the RFQ, ticked again to send with a later mail, and each mail keeps the copy it went out with. What each mail asked about each line is kept with the line (rfq_invite_lines.asked_questions), so the RFQ shows exactly what each supplier was asked; lines sent before question sets were kept count as asked the earlier fixed list. Every mail the workspace sends on an RFQ (requests, reminders, messages) has the user sending it, and the buyer who opened the RFQ, in CC, so they see it in their own mailbox and a supplier answering all reaches them too. The copy goes to the user's account address when it is a company address (COMPANY_EMAIL_DOMAINS); an address such as merve@srm.local gets none, and the RFQ pages say so.
Answers: the mailbox reader matches a reply by the Message-ID it answers (In-Reply-To/References), so it lands on its RFQ and supplier even when the subject was changed or someone else answers; otherwise by the RFQ reference in the subject and the sender's address or domain. The sender becomes a supplier contact.
Quotes: with ANTHROPIC_API_KEY, the answer and its PDF are read into draft rows, one per line quoted (by the line number or the part number the supplier gives; several rows for options on one line, an alternate part number kept as offered): condition, release form, price, core charge, lead time, the answers to the line's questions (fees, BER limit, turnarounds, core due days, O&A cap, late fee …), and for the quote validity or days the price is held firm, warranty, delivery terms, charges not included and core terms, with the limiting sentences copied word for word. Each value shows the quote from the mail it was read from, the line's own quotes for the line's values (amber when there is none), next to the supplier's mail and attachments. A term the reading gave for another line type, or could not read as a number or a value of its list, is left out with a note to check. A new answer that does not restate the terms of the supplier's earlier offer on the line (a price match) keeps them, with a note saying which. The check form shows every value the AI filled, each line's terms under it, so nothing is saved unseen; a value the answer does not state (price, currency, lead time, condition, validity, warranty) is never guessed: the field is marked ?, counted above the form, and waits to be typed in, and what is still missing stays on the saved quote (quotes.missing_fields) so the gap has a counterpart in the system; a quote typed by hand has the same fields. A line the supplier cannot quote is marked declined for it; a decline of the whole request declines the supplier; either waits as read as declined, check until a buyer keeps or undoes it. Supply corrects and confirms an answer at once; quotes can also be typed in by hand. A price match comes back as revision 2; the comparison shows the index before and after.
Comparison and pre-evaluation: Lines and quotes shows every line against every supplier (price, lowest in green, or where the answer stands) with each supplier's total for its lines; each line opens its full comparison: latest confirmed revision per supplier, price index per currency (lowest = 100), arrival against the need date, validity, unread exclusions. Its columns follow the line type: every type shows the delivery terms (Incoterm and place) and the charges not included; a repair its turnarounds (days to quote, days to repair); the terms of the type sit in a row under each quote, so the comparison fits a laptop screen and prints whole (a repair its evaluation and no-fault-found fees and BER limit; an exchange its core charge, core due days and basis, O&A cap, late core fee and core BER; a loan its terms). A question the supplier was asked and did not answer reads not stated in amber. No landed cost is worked out: the workspace has no freight or duty figures, so the charges not included are listed instead. Each supplier carries its standing for the line's type. Above the quotes, Last agreed gives the latest price agreed for the part in a negotiation record (price, condition, line type, unit, date, supplier, order, age, old after the months set), and apart from it the latest price paid without negotiation. Under each quote's price: +6% vs last agreed (same supplier, OH), against the same supplier's last agreed price for the part it offers, else the latest with any supplier. The percentage shows only in the same currency (none is converted), line type and unit, for the same part; a condition, type or unit not on file still gives it, marked; a known difference, or a price agreed at no charge (a warranty job), reads not comparable. A quote past its validity cannot be chosen until reconfirmed, nor one from a disqualified supplier; choosing one that is not the lowest, arrives late, is above the price last agreed with the same supplier (comparable, and not old), or comes from a supplier whose standing asks for it (conditional, suspended, approval expired, pending once the first review is done) needs a reason, and every reason that applies is listed. Choose per line, Choose the lowest on every line (lines whose lowest needs a reason are left for the buyer, each with why), or All to one supplier (one reason covers its lines, listed line by line). The standing at the moment of choice is kept on the line. A line no longer needed is dropped (and can be taken back).
Conversation: reminders (listing the lines not answered yet, with the questions they were asked) and messages to a supplier go as answers in the same thread, so its reply lands back on the RFQ. Ask what is missing (on the comparison and under Suppliers asked, with the count) sends a supplier, in its thread, only the questions its confirmed quote left unanswered, line by line, and those about the whole quote once; with options on a line, a question counts as answered only when every option answers it. 6a. Follow-up (Answers to chase): tiles and columns count, per RFQ and in all, the suppliers asked, quotes received, declines, those still within the answer time and those late; late suppliers (AOG first) can be reminded one by one or all at once (anyone reminded in the last 12 hours is left out; the hours are on the Settings page). Answers to check, answers without a quote, decisions and orders to place are listed there and on My desk.
Order: the chosen lines are grouped by supplier. After each order is placed in Wings and ALL ORDERS imported, linking it (to all of a supplier's lines, or to those ticked) saves a negotiation record per line from the RFQ (suppliers asked, first offer and price agreed, Last agreed with the percentage, lead time, warranty, the reason for the choice and Supplier standing at choice; the condition, unit, Wings line and part offered as fields; the answered terms (delivery, exchange, repair and loan terms) as the record's terms fields, and what has no field, such as the days the price is firm, the supplier's own core and other terms and the exclusions, as text) and puts the supplier's RFQ mail on the order. An exchange line linked gets its core, with the clock from those terms. The RFQ is ordered once every line has its order.
Sending needs MAIL_SEND_PROVIDER (graph, which is the default with MAILBOX_PROVIDER=graph, or smtp with SMTP_HOST, SMTP_PORT, SMTP_USER, SMTP_PASSWORD), MAIL_FROM (default MAILBOX_ADDRESS) and optionally MAIL_FROM_NAME. For Microsoft 365 the app registration also needs the application permission Mail.Send, limited to the workspace mailbox. Until sending is set up, RFQs can be prepared and saved."""

catalog_path = Path("ai_agents/core/page_catalog.json")
page_elements = {}
if catalog_path.exists():
    with open(catalog_path, "r", encoding="utf-8") as f:
        master_catalog = json.load(f)
        page_elements = master_catalog.get("http://localhost:3131/rfqs/new", {})


PAGE_CATALOG = f"""
TARGET PAGE: http://localhost:3131/rfqs/new
ELEMENTS REGISTRY:
{json.dumps(page_elements, indent=2, ensure_ascii=False)}
"""

BUSINESS_KNOWLEDGE = """
SRM SYSTEM RULES & BUSINESS LOGIC:

The url for the app is 'http://localhost:3131' use that as the base url for all the test cases. 
Generate test cases based on the following business knowledge and rules. Each test case should be in Gherkin format, including a feature description, scenarios, and steps. Ensure that the test cases cover various aspects of the business logic, including Wings exports, mail intake, RFQ and quotes, and any other relevant processes.
Devide the topics in business knowledge section into features and based on that generate feature files for each feature.
"""

RAW_INSTRACTIONS = """
1. The importer reads Wings headings as-is (ORDER #, VENDOR #, ORDERED BY EMPLOYEE NAME, RECEIPT DT., REQ. ORDER PRIORITY). Aliases and Turkish translations are mapped in src/lib/import/mappings.ts.

2. Raw order exports (EXCEL.ORDER_EXPORT...xlsx, headings like ORDER_NUMBER, ORDER_LINE, LINE_STATUS, VENDOR_NAME) read all order series (PO-, RO-, CA-, SE-, CF-), statuses, and requisitions. Unmatched suppliers are set as Pending review. Cost columns are ignored. Status CREATED counts as open. Merged-cell report layouts are ignored.

3. Requisitions (RQ-, RQA-) are processed line-by-line with requester, buyer, priority, date needed, and linked orders. Requisition-only tool loan lists are rejected.

4. Scheduled email report attachments (.xlsx, .csv) from senders in WINGS_REPORT_SENDERS are automatically imported.

5. Supported import file formats and encodings: CSV and TXT files in UTF-8, UTF-16, or Windows-1254 (Turkish Excel).

6. Heading row detection: System scans for the header row within the first 20 rows of the file.

7. Date parsing formats: Supports spreadsheet serial dates, YYYY-MM-DD, DD.MM.YYYY, or DD-MON-YY (e.g., 05-JUN-25).

8. Number formatting: Supports decimal separators in either 1.250,50 or 1,250.50 formats.

9. Workbooks with multiple sheets are imported sheet-by-sheet. Tool loan lists load borrowed and lent sheets in one upload. Unmatched sheet headings trigger a rejection.

10. Supplier list imports require a vendor number, e-mail, country, or payment terms column alongside the supplier name.

11. Import page accepts files up to 25 MB; larger files must use import-wings.sh.

12. ALL ORDERS imports capture ORDER CONFIRMATION, CONF.DATE, shipment info (SHIP DATE, ETA DT., CARRIER), WAYBILL, receiving details (LOT #, EXPIRE DT., CERT. DT.), and customs codes (HS CODE/GTİP, ECCN CODE). Empty or missing columns in a new import do not clear previously imported data.

13. ALL ORDERS exports exclude prices; agreed prices derive from negotiation records. UNIT PRICE and CURRENCY are extracted if present.

14. Rejection scorecards only count supplier-fault discrepancies (mismatched serial, expiry, part/lot, or unserviceable/quarantine arrivals). Condition differences on repairs are excluded from penalties.

15. 12-month performance comparisons require historical receiving data spanning the entire 12-month window.

16. On-time delivery performance is measured strictly against the Wings required date (needed date), not the supplier's confirmed date.

17. Mail intake supports three channels: manual uploads (.msg or .eml), automated mailbox polling, or the inbound API endpoint.

18. Email authentication check: SPF, DKIM, and DMARC results are validated. Failures mark emails as "Sender unverified" and halt automated workflow execution.

19. Colleague email forwards from COMPANY_EMAIL_DOMAINS extract original supplier conversations (sender, recipients, date, subject, forwarder) from Outlook, Gmail, and Apple Mail headers.

20. Order matching priority order: 1) Order number in subject/body (PO-XXXXX, PO XXXXX, sipariş no), 2) Order number in attachments, 3) Manually assigned order on upload, 4) Supplier contact match with matching active part number (-180 to +90 days), 5) Existing email thread.

21. Unmatched RFQ mail filed manually from the inbox maps to the selected RFQ and supplier conversation, saving the sender as a contact for future auto-matching.

22. Replies to chase emails match by Message-ID, attach to all listed orders (emails.order_nos), and update order news records.

23. Corrective Action (CAR) email replies match by Message-ID or [CAR-26-0001] subject tag, attaching directly to the CAR record.

24. Attachment parsing extracts text from PDF, DOCX, DOC, XLSX, CSV, TXT, and HTML. Unreadable files are tagged as "? not read" for manual entry.

25. Automated AI drafting creates a draft negotiation record when email arrives on an open order (requires ANTHROPIC_API_KEY).

26. Mailbox polling reads the target inbox every MAILBOX_POLL_MINUTES (default: 5) and moves processed messages to "SRM processed".

27. Dual mailbox routing: Supply mailbox handles supplier communications; Sales mailbox (SALES_MAILBOX_ADDRESS) handles customer inquiries and stays isolated from supply workflows.

28. Microsoft 365 integration requires MAILBOX_PROVIDER=graph, MS_TENANT_ID, MS_CLIENT_ID, and MS_CLIENT_SECRET, scoped to a single mailbox via Exchange application access policy.

29. RFQ creation captures line items (part number, description, quantity, unit, type: outright/exchange/repair/loan, conditions, needed date), priority, response deadline, and target suppliers.

30. RFQ dispatch sends one email per supplier in English with structured line items, numbered questions, [RFQ-YY-XXXX] subject tag, and unique Message-ID headers, keeping the buyer in CC.

31. RFQ email replies match automatically via In-Reply-To/References headers or RFQ reference subject tags.

32. AI quote reading parses email replies into draft quote rows per line item. Unstated fields are tagged with "?" and tracked in quotes.missing_fields.

33. Quote evaluation matrix displays line-by-line price comparisons, currency index (lowest = 100), lead times, and variances against historical agreed prices. Non-lowest selections require justification reasons.

34. Automated follow-ups track supplier response times and permit bulk or single reminders for late respondents.

35. Order creation links selected RFQ lines to Wings orders, generating immutable Negotiation Records capturing agreed terms, lead times, warranties, and selection reasons.

36. Mail sending setup requires MAIL_SEND_PROVIDER (graph or smtp), MAIL_FROM, and Microsoft 365 Mail.Send application permissions.
"""