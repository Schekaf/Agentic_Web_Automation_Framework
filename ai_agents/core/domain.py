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