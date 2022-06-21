document.addEventListener("DOMContentLoaded", main)

function main() {
    init_spells()

    init_users()
    init_register()
    init_login()
    init_logout()

    init_spellbooks()
    init_create_spellbook()

    current_user_callback()
}

function init_spells() {
    const button = document.querySelector(".spells_button")
    const text = document.querySelector(".spells_text")

    button.addEventListener('mouseup', () => {
        const page = 1
        const page_size = 2
        const args = `?page=${page}&page_size=${page_size}`

        request('get', `/api/spells${args}`)
            .then((res) => res.json())
            .then((json) => text.textContent = JSON.stringify(json, null, 2));
    })
}

function init_users() {
    const button = document.querySelector(".users_button")
    const text = document.querySelector(".users_text")

    button.addEventListener('mouseup', () => {
        const page = 1
        const page_size = 2
        const args = `?page=${page}&page_size=${page_size}`

        request('get', `/api/users${args}`)
            .then((res) => res.json())
            .then((json) => text.textContent = JSON.stringify(json, null, 2));
    })
}

function init_register() {
    const button = document.querySelector(".register_button")
    const nickname = document.querySelector(".nickname_field")
    const email = document.querySelector(".email_field")
    const password = document.querySelector(".password_field")

    const result = document.querySelector(".result_field")

    button.addEventListener('mouseup', () => {
        let body = {
            nickname: nickname.value,
            email: email.value,
            password: password.value,
        }
        request('POST', '/api/users')
            .then((res) => res.json())
            .then((json) => {
                result.textContent = JSON.stringify(json, null, 2);
                if (json.access_token) {
                    window.localStorage.setItem('logged_in', true)
                    window.localStorage.setItem('auth_token', json.access_token)
                }
            });
    })
}

function init_login() {
    const button = document.querySelector(".login_button")
    const nickname = document.querySelector(".login_nickname_field")
    const password = document.querySelector(".login_password_field")

    const result = document.querySelector(".login_result_field")

    button.addEventListener('mouseup', () => {
        let body = {
            nickname: nickname.value,
            password: password.value,
        }
        request('POST', '/api/login', JSON.stringify(body))
            .then((res) => res.json())
            .then((json) => {
                result.textContent = JSON.stringify(json, null, 2);
                if (json.access_token) {
                    window.localStorage.setItem('logged_in', true)
                    window.localStorage.setItem('auth_token', json.access_token)
                    window.localStorage.setItem('nickname', body.nickname)
                    current_user_callback()
                }
            })
    })
}

var current_user_callback;

function init_logout() {
    const button = document.querySelector(".logout_button")
    const nickname = document.querySelector(".current_user_field")

    button.addEventListener('mouseup', () => {
        window.localStorage.removeItem('logged_in')
        window.localStorage.removeItem('auth_token')
        window.localStorage.removeItem('nickname')
        current_user_callback()
    })

    current_user_callback = () => {
        if (window.localStorage.getItem('logged_in')) {
            nickname.value = window.localStorage.getItem('nickname')
        } else {
            nickname.value = '<none>'
        }
    }
}

function init_spellbooks() {
    const button = document.querySelector(".spellbooks_button")
    const text = document.querySelector(".spellbooks_text")

    button.addEventListener('mouseup', () => {
        const page = 1
        const page_size = 2
        const args = `?page=${page}&page_size=${page_size}`

        request('get', `/api/spellbooks${args}`)
            .then((res) => res.blob())
            .then((res) => res.text())
            .then((json) => text.textContent = json);
    })
}

function init_create_spellbook() {
    const button = document.querySelector(".create_spellbooks_button")

    const character_name = document.querySelector(".character_name_field")
    const character_level = document.querySelector(".character_level_field")
    const spell_ids = document.querySelector(".spell_ids_field")

    const result = document.querySelector(".spellbooks_result_field")

    button.addEventListener('mouseup', () => {
        let body = {
            character_name: character_name.value,
            character_level: +character_level.value,
            spells: spell_ids.value.split(' ').map(it => +it),
        }
        request('POST', '/api/spellbooks', JSON.stringify(body))
            .then((res) => res.blob())
            .then((res) => res.text())
            .then((json) => result.textContent = json);
    })
}

function request(verb, path, body) {
    const headers = {}

    if (window.localStorage.getItem('logged_in')) {
        headers['Authorization'] = `Bearer: ${window.localStorage.getItem('auth_token')}`
    }

    if (body) {
        headers['Accept'] = 'application/json';
        headers['Content-Type'] = 'application/json';
    }

    return fetch(path, {
        method: verb,
        headers: headers,
        body: body
    })
}