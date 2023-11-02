from quart import Quart, request, jsonify
import os
import datetime
import pytz
from telethon import TelegramClient
from telethon.errors import ChannelPrivateError

app = Quart(__name__)

api_id = os.getenv('TELEGRAM_API_ID')
api_hash = os.getenv('TELEGRAM_API_HASH')

async def fetch_messages(channel_name, hours):
    async with TelegramClient('anon', api_id, api_hash) as client:
        try:
            # Check if the channel is accessible
            await client.get_entity(channel_name)
        except ChannelPrivateError:
            return {'error': 'The channel is private or inaccessible'}, 403
        except ValueError as e:
            return {'error': str(e)}, 400

        # Define the time range for fetching messages
        timezone = pytz.timezone('UTC')  # Use your preferred timezone
        end_date = datetime.datetime.now(timezone)
        start_date = end_date - datetime.timedelta(hours=hours)

        limit = 50
        messages = []
        total_messages_fetched = 0
        last_message_id = -1

        while True:
            async for message in client.iter_messages(channel_name, limit=limit, max_id=last_message_id):
                message_date = message.date.astimezone(timezone)
                if message_date < start_date:
                    return messages, 200

                if start_date <= message_date <= end_date and message.text:
                    messages.append({
                        'date': str(message_date),
                        'text': message.text,
                    })

                total_messages_fetched += 1
                last_message_id = message.id - 1

            if total_messages_fetched < limit:
                break

        return messages, 200


@app.route('/get_messages', methods=['GET'])
async def get_messages():
    channel_name = request.args.get('channel_name')
    hours = request.args.get('hours', type=int)

    if not channel_name or not hours:
        return jsonify({'error': 'Channel name and amount of hours are required'}), 400

    messages, status = await fetch_messages(channel_name, hours)
    return jsonify(messages), status

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True)
