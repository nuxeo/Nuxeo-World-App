/**
 * This file is part of CODESTRONG Mobile.
 *
 * CODESTRONG Mobile is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * CODESTRONG Mobile is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with CODESTRONG Mobile.  If not, see <http://www.gnu.org/licenses/>.
 */
(function () {

    Codestrong.ui.createDayWindow = function (tabGroup) {
        // Base row properties
        var baseRow = {
            hasChild: true,
            color: '#000',
            backgroundColor: '#fff',
            font: {
                fontWeight: 'bold'
            }
        };
        baseRow[Codestrong.ui.backgroundSelectedProperty + 'Color'] = Codestrong.ui.backgroundSelectedColor;

        // Creates a TableViewRow using the base row properties and a given
        // params object
        var createDayRow = function (params) {
            return Codestrong.extend(Ti.UI.createTableViewRow(params), baseRow);
        };

        // Create data for TableView
        var data = [
	        createDayRow({
	            title: 'Thursday, October 20th',
	            titleShort: 'October 20th',
	            start_date: '2011-10-20 00:00:00',
	            end_date: '2011-10-21 00:00:00',
	            scheduleListing: true
	        }), createDayRow({
	            title: 'Friday, October 21th',
	            titleShort: 'October 21th',
	            start_date: '2011-10-21 00:00:00',
	            end_date: '2011-10-22 00:00:00',
	            scheduleListing: true
	        })
        ];

        // create main day window
        var dayWindow = Titanium.UI.createWindow({
            id: 'win1',
            title: 'Schedule',
            backgroundColor: '#fff',
            barColor: '#414444',
            fullscreen: false
        });
        var tableview = Titanium.UI.createTableView({
            data: data
        });
        dayWindow.add(tableview);

        tableview.addEventListener('click', function (e) {
            if (e.rowData.scheduleListing) {
                Codestrong.navGroup.open(Codestrong.ui.createSessionsWindow({
                    titleShort: e.rowData.titleShort,
                    title: e.rowData.title,
                    start_date: e.rowData.start_date,
                    end_date: e.rowData.end_date
                }), {
                    animated: true
                });
            } else {
                Codestrong.navGroup.open(Codestrong.ui.createHtmlWindow({
                    title: e.rowData.titleShort,
                    url: e.rowData.url
                }), {
                    animated: true
                });
            }

        });

        return dayWindow;
    };
})();