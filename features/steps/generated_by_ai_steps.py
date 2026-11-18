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

@step('I perform "{action}" action')
def step_perform_action(context, action):
    context.page.click(action)

@step('I apply for a "{type}"')
def step_apply_for_type(context, type):
    context.page.click(f'apply-for-{type}')

@step('I accept "{job}" job')
def step_accept_job(context, job):
    context.page.click(f'accept-{job}-job')

@step('I see {element} is selected as current tab')
def step_check_current_tab(context, element):
    assert context.page.get_attribute(element, 'aria-selected') == 'true'

@step('I see a list of "{items}"')
def step_check_list_items(context, items):
    assert context.page.get_text('list-items') == items

@step('I select "{option}" as {element}')
def step_select_option_as_element(context, option, element):
    context.page.click(f'{element}-{option}')

@step('I do not select "{option}" as {element}')
def step_do_not_select_option_as_element(context, option, element):
    context.page.click(f'{element}-not-{option}')

@step('I do not see {element}')
def step_check_element_not_visible(context, element):
    assert not context.page.is_visible(element)


@step('I scroll down the page')
def step_scroll_down_page(context):
    context.page.scroll_to_bottom()

@step('I select a "{option}"')
def step_select_option(context, option):
    context.page.click(option)

@step('I press on "{element}"')
def step_press_element(context, element):
    context.page.press(element)


@step('I see {element} field is required')
def step_check_required_field(context, element):
    assert context.page.get_attribute(element, 'required') == 'true'

@step('I see "{page}" page')
def step_check_page(context, page):
    assert context.page.get_title() == page

@step('I receive "{message}"')
def step_receive_message(context, message):
    assert context.page.get_text('message') == message

@step('I click {element}')
def step_click_element(context, element):
    context.page.click(element)

@step('I see {element} contains "{value}"')
def step_check_element_contains_value(context, element, value):
    assert value in context.page.get_text(element)

@step('I wait for "{condition}"')
def step_wait_for_condition(context, condition):
    context.page.wait_for_condition(condition)

@step('I see "{element}" is selected as "{state}"')
def step_check_element_selected_state(context, element, state):
    assert context.page.get_attribute(element, 'aria-selected') == state

@step('I see "{element}"')
def step_check_element(context, element):
    assert context.page.is_visible(element)


@step('I click on {element}')
def step_click_on_element(context, element):
    context.page.click(element)

@step('I open "{element}"')
def step_open_element(context, element):
    context.page.click(element)


@step('I am "{status}"')
def step_check_status(context, status):
    assert context.page.get_text('status') == status

@step('I see "{tag}" is selected as Tag')
def step_check_tag_selected(context, tag):
    assert context.page.get_attribute(tag, 'aria-selected') == 'true'


@step('I navigate to the "{page}"')
def step_navigate_to_page(context, page):
    context.page.goto(page)


@step('I upload "{file}" as Attachment')
def step_upload_attachment(context, file):
    context.page.set_input_files('attachment', file)

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
