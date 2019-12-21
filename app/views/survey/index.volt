<div id="container">
    <img src="/img/ats_logo_small.jpg" alt="ATS Timber" class="ats-logo"/>
    <h1>Hi
        {% if contact is defined %}
        {{ contact.name }}
        {% else %}
        there!
        {% endif %}
    </h1>
    <h2>ATS Timber aims to be the easiest timber company to deal with in New Zealand.  This survey allows us to monitor and improve the level of service we provide to our customers. </h2>
    <form method="post" action="/survey/submit" id="survey">
        {{ hidden_field('contact', 'value': contact.id ) }}
        {{ hidden_field('customer', 'value': contact.customerCode ) }}
        {% for j, k in questions %}
        <div class="question">
            <strong>{{ k }}</strong>
            <div class="radio-list wide">
                <span class="scale poor">Poor</span>
                <span class="scale excellent">Excellent</span>
                <div class="clear-mobile"></div>
                {% for key, i in scale %}
                <div class="radio3">
                    <input type="radio" name="result{{ j }}" id="result{{ j }}-{{ loop.index }}" value="{{ loop.index }}" class="css-checkbox">
                    <label for="result{{ j }}-{{ loop.index }}" class="css-label radGroup{{ j }}">
                        {{ key }}
                    </label>
                </div>
                {% endfor %}
            </div>
            <div class="clear"></div>
        </div>
        {% endfor %}

        <div class="question">
            <p><strong>How would you recommend ATS Timber to your clients?</strong></p>
            <div class="radio3">
                <input type="radio" name="recommend" id="optionOne" class="css-checkbox" value="1">
                <label for="optionOne" class="css-label radGroup{{ j + 1 }}">
                    I would go out of my way to recommend ATS Timber
                </label>
            </div>
            <div class="radio3">
                <input type="radio" name="recommend" id="optionTwo" class="css-checkbox" value="2">
                <label for="optionTwo" class="css-label radGroup{{ j + 1 }}">
                    I would recommend ATS Timber
                </label>
            </div>
            <div class="radio3">
                <input type="radio" name="recommend" id="optionThree" class="css-checkbox" value="3">
                <label for="optionThree" class="css-label radGroup{{ j + 1 }}">
                    I would <i>not</i> recommend ATS Timber
                </label>
            </div>
        </div>
        <div class="question">
            <div class="form-control wide">
                <label for="feedback">How can we do better?</label>
                <textarea id="feedback" name="feedback" rows="8" cols="40"></textarea>
            </div>
        </div>

        <div class="form-control wide">
            <button type="submit">Submit</button>
        </div>
    </form>
</div>
