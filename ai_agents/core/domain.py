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
DOCUMENT = """
Wings exports
The importer reads the Wings headings as they are (ORDER #, VENDOR #, ORDERED BY EMPLOYEE NAME, RECEIPT DT., REQ. ORDER PRIORITY, …). Aliases for other headings, including Turkish ones, are in src/lib/import/mappings.ts; switching to Veryon means adding its headings there.

The raw order export. Besides its report layouts, Wings gives the order list as a raw export (EXCEL.ORDER_EXPORT…xlsx, headings such as ORDER_NUMBER, ORDER_LINE, LINE_STATUS, VENDOR_NAME). It is read like ALL ORDERS and carries every order series (purchase PO-, repair RO-, calibration CA-, service SE-, CF-), all statuses, and the requisitions as well. Its cost columns are not imported. It has no vendor number yet, so its suppliers are matched by name; a name not known yet is added as Pending review, and gets its vendor number when a later list brings one. A line Wings shows as CREATED counts as open. The report layouts (WEBREP…IC_588, PDF or Excel) cannot be read: merged cells and combined columns.

Requisitions. Requests for parts (RQ-… raised by people, RQA-… raised from min/max levels) come in the same Wings lists as the orders, under ORDER # with order type REQUISITION. They are kept apart from the orders, one row per request line with who asked, the buyer, priority, the date needed and the purchase or repair orders placed for it (PURCHASE_REPAIR_ORDER_NUMBER, several when it was ordered in parts). The Requests page lists those still waiting for an order (where an RFQ starts, prefilled from the request), those ordered and open, and the days from request to order; an order shows the requests behind it. A tool loan list made only of requisitions is refused.

Reports by mail. When Wings sends its reports on a schedule (or a colleague mails them) to the workspace mailbox, they are imported by themselves: mail from a sender listed in WINGS_REPORT_SENDERS whose .xlsx or .csv attachments are lists the import knows is imported as an upload would be (supplier lists first, then orders, then receiving and tool loans), logged under the sender's account or else the first admin, and not kept as negotiation mail. Other mail from those senders is taken in as usual. The Import page shows the reports received and what each import changed.

CSV and .txt files may be UTF-8, UTF-16 (“Unicode text”) or Windows-1254 (Turkish Excel).
The heading row may sit below a title or print-date line, within the first 20 rows.
Dates may be real spreadsheet dates, YYYY-MM-DD, day-first DD.MM.YYYY, or DD-MON-YY as Wings writes some (05-JUN-25).
Numbers may use either decimal convention (1.250,50 or 1,250.50).
A workbook with several sheets is imported sheet by sheet; the tool loan list (borrowed and lent sheets) loads in one upload. A list type chosen by hand on the Import page applies to every sheet it fits; a sheet with another list's headings is refused with a message.
A supplier list needs a vendor number, e-mail, country or payment terms column next to the name.
The Import page takes files up to 25 MB; use import-wings.sh (above) for bigger ones.
From the ALL ORDERS layout the import also reads the supplier's order confirmation (ORDER CONFIRMATION, CONF.DATE), the shipment (SHIP DATE, ETA DT., CARRIER; each new value is kept as an order event from Wings for the chase list, an ORDER CONFIRMATION of N, NO, FALSE, 0 or - counting as none until Wings' own values are confirmed), and WAYBILL, shown on the chase list but not counted as the supplier's shipment (whether it is the inbound or our outbound shipment on a repair order is to confirm), and from the receiving list LOT #, EXPIRE DT., CERT. DT., and the part's HS CODE (customs tariff code, GTİP) and ECCN CODE, which prefill a customs file for the same part; its SHIPMENT INV. and CUSTOMS INV. columns are not read (whether they hold invoice numbers or amounts is to confirm, and an amount is never imported). The raw ORDER_EXPORT has none of these columns yet (nor condition, unit, aircraft, essentiality, ship-by, waybill or destination): a list without a column never blanks what an earlier list gave. Each import records the columns it had, so a screen can tell a field no imported list carries (not in the Wings list) from one Wings left empty.
The ALL ORDERS export has no prices; agreed prices come from negotiation records. The order report v2 has REPAIR COST, EXCHANGE COST and LIST PRICE columns; they are left out on purpose. If Wings can add unit price and currency to the export, they are picked up automatically (UNIT PRICE, CURRENCY).
Wings marks receipt lines REJECTED when condition, serial, expiry, part or lot differ from the order. The scorecard counts as receiving discrepancies only the supplier's problems: serial, expiry, part or lot mismatches, and parts arriving unserviceable (US) or in quarantine (QUAR). A repair returned in another condition than ordered (for example OH or INS instead of RE) is shown but not counted (Supply management's decision). A rejection stays counted after Wings clears the status. A buyer's review of a delivery comes first (see Receiving problems and corrective actions): one marked not the supplier's fault is left out, one a buyer counted is in. Whether the receiving list's CERT. N means a missing release document is to confirm, so it is not read as missing documents.
Comparisons with the previous 12 months are shown only when the receiving list reaches back over that whole period.
The Wings due date is the date the part was needed, not a supplier-confirmed date, so on-time figures are strict."""


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