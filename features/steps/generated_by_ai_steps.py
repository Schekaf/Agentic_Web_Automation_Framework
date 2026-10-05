# Auto-generated step definitions by Phase 3 Pipeline (qwen2.5-coder:7b)
from utilities.step_helper import step

@step('I enter "{value}" as {element}')
def step_input_value_into_element(context, value, element):
    context.page.fill(element, value)

@step('I see "{element}" is "{state}"')
def step_check_element_state(context, element, state):
    assert context.page.get_attribute(element, 'data-state') == state

@step('I see "{element}" is visible')
def step_check_element_visibility(context, element):
    assert context.page.is_visible(element)

@step('I enter "{value}" as Budget')
def step_input_budget(context, value):
    context.page.fill('budget', value)

@step('I perform "{action}" action')
def step_perform_action(context, action):
    context.page.click(action)

@step('I apply for a "{type}"')
def step_apply_for_type(context, type):
    context.page.click(f'apply-for-{type}')

@step('I accept "{job}" job')
def step_accept_job(context, job):
    context.page.click(f'accept-{job}-job')

@step('I see "{element}" is selected as current tab')
def step_check_current_tab(context, element):
    assert context.page.get_attribute(element, 'aria-selected') == 'true'

@step('I see a list of "{items}"')
def step_check_list_items(context, items):
    assert context.page.get_text('list-items') == items

@step('I enter "{value}" as Tender Title')
def step_input_tender_title(context, value):
    context.page.fill('tender-title', value)

@step('I select "{option}" as {element}')
def step_select_option_as_element(context, option, element):
    context.page.click(f'{element}-{option}')

@step('I do not select "{option}" as {element}')
def step_do_not_select_option_as_element(context, option, element):
    context.page.click(f'{element}-not-{option}')

@step('I do not see "{element}"')
def step_check_element_not_visible(context, element):
    assert not context.page.is_visible(element)

@step('I see "{element}" in "{context}"')
def step_check_element_in_context(context, element, context_name):
    assert context.page.get_text(f'{context_name}-{element}')

@step('I scroll down the page')
def step_scroll_down_page(context):
    context.page.scroll_to_bottom()

@step('I select a "{option}"')
def step_select_option(context, option):
    context.page.click(option)

@step('I press on "{element}"')
def step_press_element(context, element):
    context.page.press(element)

@step('I am logged out of the TradeHub system')
def step_log_out_tradehub_system(context):
    context.page.click('logout')

@step('I see "{element}" field is required')
def step_check_required_field(context, element):
    assert context.page.get_attribute(element, 'required') == 'true'

@step('I attempt to send a message to Account "{account}"')
def step_attempt_send_message_to_account(context, account):
    context.page.fill('message-to', account)
    context.page.click('send-message')

@step('I select "{option}" as Attachment')
def step_select_attachment_option(context, option):
    context.page.click(f'attachment-{option}')

@step('I see "{page}" page')
def step_check_page(context, page):
    assert context.page.get_title() == page

@step('I receive "{message}"')
def step_receive_message(context, message):
    assert context.page.get_text('message') == message

@step('I enter "{value}" field')
def step_input_field_value(context, value):
    context.page.fill('input-field', value)

@step('I click "{element}"')
def step_click_element(context, element):
    context.page.click(element)

@step('I enter "{value}" as ABN')
def step_input_abn(context, value):
    context.page.fill('abn', value)

@step('I see "{element}" contains "{value}"')
def step_check_element_contains_value(context, element, value):
    assert value in context.page.get_text(element)

@step('I enter "{value}" as Start Date')
def step_input_start_date(context, value):
    context.page.fill('start-date', value)

@step('I wait for "{condition}"')
def step_wait_for_condition(context, condition):
    context.page.wait_for_condition(condition)

@step('I see "{element}"')
def step_check_element(context, element):
    assert context.page.is_visible(element)

@step('I enter "{value}" as Password')
def step_input_password(context, value):
    context.page.fill('password', value)

@step('I am logged into the TradeHub system')
def step_log_into_tradehub_system(context):
    context.page.fill('username', 'user')
    context.page.fill('password', 'pass')
    context.page.click('login')

@step('I click on "{element}"')
def step_click_on_element(context, element):
    context.page.click(element)

@step('I see "{element}" is selected as "{state}"')
def step_check_element_selected_state(context, element, state):
    assert context.page.get_attribute(element, 'aria-selected') == state

@step('I open "{element}"')
def step_open_element(context, element):
    context.page.click(element)

@step('I enter "{value}" as Recipient')
def step_input_recipient(context, value):
    context.page.fill('recipient', value)

@step('I enter "{value}" as Message')
def step_input_message(context, value):
    context.page.fill('message', value)

@step('I am "{status}"')
def step_check_status(context, status):
    assert context.page.get_text('status') == status

@step('I see "{tag}" is selected as Tag')
def step_check_tag_selected(context, tag):
    assert context.page.get_attribute(tag, 'aria-selected') == 'true'

@step('I enter "{value}" as Email')
def step_input_email(context, value):
    context.page.fill('email', value)

@step('I enter "{value}" as End Date')
def step_input_end_date(context, value):
    context.page.fill('end-date', value)

@step('I reopen the browser')
def step_reopen_browser(context):
    context.page.close()
    context.page = context.browser.new_page()

@step('I navigate to the "{page}"')
def step_navigate_to_page(context, page):
    context.page.goto(page)

@step('I select "{option}" as Radius')
def step_select_radius_option(context, option):
    context.page.click(f'radius-{option}')

@step('I upload "{file}" as Attachment')
def step_upload_attachment(context, file):
    context.page.set_input_files('attachment', file)

@step('I enter "{value}" as Quote Amount')
def step_input_quote_amount(context, value):
    context.page.fill('quote-amount', value)

@step('I see a list of messages')
def step_check_list_of_messages(context):
    assert context.page.get_text('messages-list')

@step('I navigate to the "{section}" section')
def step_navigate_to_section(context, section):
    context.page.click(section)

@step('I open "{element}" on a mobile device')
def step_open_element_on_mobile(context, element):
    context.page.click(element)
    context.page.wait_for_selector('mobile-view')
