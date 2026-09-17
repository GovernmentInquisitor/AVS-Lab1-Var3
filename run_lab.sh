#!/bin/bash
rm -rf lab0
mkdir lab0
cd lab0
git init
mkdir -p claude_monet/hall claude_monet/reception claude_monet/bar claude_monet/terrace claude_monet/kitchen claude_monet/staff_room
cat > claude_monet/hall/table_plan << 'INNER_EOF'
Столик 1 закреплён за Настей
Столик 4 обслуживает Саша
Столик 7 оставить для Дмитрия Нагиева
Большой стол подготовить к банкету
INNER_EOF
cat > claude_monet/hall/guest_requests << 'INNER_EOF'
Гости у окна просят позвать Вику
За столиком 4 ждут десерт от Луи
Постоянный гость заказал блюдо Баринова
INNER_EOF
cat > claude_monet/reception/reservations << 'INNER_EOF'
Семья заказала столик на шесть часов
Друзья Кости придут после вечерней смены
Для владельца ресторана оставлен столик 7
Настя подтвердила все бронирования
INNER_EOF
cat > claude_monet/reception/complaints << 'INNER_EOF'
Гость слишком долго ждал горячее
За столиком 2 перепутали заказ
Вика обещала лично решить проблему
INNER_EOF
cat > claude_monet/bar/kostya_shift << 'INNER_EOF'
Костя открывает бар перед обедом
Проверяет запасы и получает лёд
После закрытия сдаёт отчёт Вике
INNER_EOF
cat > claude_monet/bar/cocktail_card << 'INNER_EOF'
Коктейль от Кости с вишнёвым соком
Безалкогольный напиток для Насти
Фирменный коктейль Claude Monet
INNER_EOF
cat > claude_monet/terrace/banquet_plan << 'INNER_EOF'
На террасе поставить восемь столов
Гостей встречают Вика и Настя
Костя готовит напитки к семи часам
Баринов представляет праздничное меню
INNER_EOF
cat > claude_monet/kitchen/special_orders << 'INNER_EOF'
Столик 1 просит блюдо без лука
Для столика 7 готовит лично шеф
Гостям на террасе подать десерт Луи
INNER_EOF
cat > claude_monet/staff_room/nastya_note << 'INNER_EOF'
Настя поменялась сменой с официанткой
Костя обещал встретить её после работы
Вика разрешила закончить смену раньше
INNER_EOF
cat > vika_report << 'INNER_EOF'
Зал готов к открытию
Официанты получили свои столики
Все жалобы нужно передать Вике
INNER_EOF
cat > nagiev_call << 'INNER_EOF'
Дмитрий Нагиев позвонил перед открытием
Владелец приедет с гостями вечером
Лучший стол должен быть свободен
INNER_EOF
git add .
git commit -m "LabCompletedTwice"
chmod 755 claude_monet
chmod u=rwx,g=rx,o=rx claude_monet/hall
chmod 644 claude_monet/hall/table_plan
chmod u=rw,g=r,o= claude_monet/hall/guest_requests
chmod 750 claude_monet/reception
chmod u=rw,g=r,o=r claude_monet/reception/reservations
chmod 600 claude_monet/reception/complaints
chmod u=rwx,g=rx,o=x claude_monet/bar
chmod 640 claude_monet/bar/kostya_shift
chmod u=r,g=r,o=r claude_monet/bar/cocktail_card
chmod 750 claude_monet/terrace
chmod u=rw,g=r,o= claude_monet/terrace/banquet_plan
chmod u=rwx,g=rx,o= claude_monet/kitchen
chmod 640 claude_monet/kitchen/special_orders
chmod 750 claude_monet/staff_room
chmod u=r,g=r,o= claude_monet/staff_room/nastya_note
chmod 644 vika_report
chmod u=rw,g=r,o=r nagiev_call
cp vika_report claude_monet/reception/manager_report
cp -r claude_monet/terrace claude_monet/hall/terrace_backup
ln -s ../reception/reservations claude_monet/bar/current_reservations
ln -s claude_monet/hall guest_hall
ln nagiev_call claude_monet/reception/owner_call
cat claude_monet/reception/reservations claude_monet/terrace/banquet_plan > claude_monet/reception/evening_guests
cat claude_monet/staff_room/nastya_note >> vika_report
mv claude_monet/reception/complaints claude_monet/hall/guest_complaints
ls -lR claude_monet | grep "^-" | sort -k5 -rn | head -n 6
grep -riih "вик\|наст" . | grep -vi "столик" | sort -r | head -n 5
grep -lh "гост" claude_monet/hall/table_plan claude_monet/hall/guest_requests claude_monet/hall/guest_complaints claude_monet/hall/terrace_backup/* 2>/dev/null | wc -l
(cat claude_monet/bar/kostya_shift claude_monet/bar/cocktail_card | grep -i "кост\|вик" | head -n 1; cat claude_monet/bar/kostya_shift claude_monet/bar/cocktail_card | grep -i "кост\|вик" | tail -n 1) | sort
grep -v "столик" claude_monet/reception/evening_guests | sort -r | head -n 4 | wc -w
ls -lR | grep "^-.* 2 " | sort -r
ls -lR | grep "^l" | grep -v "guest" | sort
rm claude_monet/staff_room/nastya_note
rm claude_monet/bar/current_reservations
rm guest_hall
rm nagiev_call
rm claude_monet/reception/owner_call
rm claude_monet/terrace/banquet_plan
rmdir claude_monet/terrace
rm -rf claude_monet/hall/terrace_backup


